import 'package:dicoding_mfde_submission/presentation/bloc/toprated/top_rated_bloc.dart';
import 'package:dicoding_mfde_submission/presentation/widgets/item_movie_tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedPage extends StatefulWidget {
  static const routeName = '/top-rated';

  final String type;

  const TopRatedPage({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  _TopRatedPageState createState() => _TopRatedPageState();
}

class _TopRatedPageState extends State<TopRatedPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TopRatedBloc>().add(TopRated(widget.type)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated ${widget.type}'.toUpperCase()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedBloc, TopRatedState>(
          builder: (context, state) {
            if (state is TopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieTvShowCard(movie, widget.type);
                },
                itemCount: state.result.length,
              );
            } else if (state is TopRatedError) {
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
