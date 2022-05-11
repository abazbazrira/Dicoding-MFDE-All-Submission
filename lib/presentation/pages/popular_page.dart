import 'package:dicoding_mfde_submission/common/state_enum.dart';
import 'package:dicoding_mfde_submission/presentation/provider/popular_movies_notifier.dart';
import 'package:dicoding_mfde_submission/presentation/widgets/item_movie_tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Future.microtask(() =>
        Provider.of<PopularMoviesNotifier>(context, listen: false)
            .fetchPopular(widget.type));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular ${widget.type}'.toUpperCase()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularMoviesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.movies[index];
                  return MovieTvShowCard(movie, widget.type);
                },
                itemCount: data.movies.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
