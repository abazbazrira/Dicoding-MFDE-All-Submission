import 'package:dicoding_mfde_submission/common/state_enum.dart';
import 'package:dicoding_mfde_submission/presentation/provider/top_rated_notifier.dart';
import 'package:dicoding_mfde_submission/presentation/widgets/item_movie_tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Future.microtask(() => Provider.of<TopRatedNotifier>(context, listen: false)
        .fetchTopRated(widget.type));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated ${widget.type}'.toUpperCase()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedNotifier>(
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
