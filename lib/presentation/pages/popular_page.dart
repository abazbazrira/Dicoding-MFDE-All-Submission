import 'package:dicoding_mfde_submission/presentation/bloc/popular/popular_bloc.dart';
import 'package:dicoding_mfde_submission/presentation/widgets/item_movie_tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularPage extends StatefulWidget {
  static const routeName = '/popular-movie';

  final String type;

  const PopularPage({Key? key, required this.type}) : super(key: key);

  @override
  _PopularPageState createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularBloc>().add(Popular(widget.type)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular ${widget.type}'.toUpperCase()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularBloc, PopularState>(
          builder: (context, state) {
            if (state is PopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieTvShowCard(movie, widget.type);
                },
                itemCount: state.result.length,
              );
            } else if (state is PopularError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text(''),
              );
            }
          },
        ),
      ),
    );
  }
}
