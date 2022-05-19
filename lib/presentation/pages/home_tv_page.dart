import 'package:dicoding_mfde_submission/common/constants.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/now_playing/now_playing_bloc.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/popular/popular_bloc.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/toprated/top_rated_bloc.dart';
import 'package:dicoding_mfde_submission/presentation/pages/popular_page.dart';
import 'package:dicoding_mfde_submission/presentation/pages/top_rated_page.dart';
import 'package:dicoding_mfde_submission/presentation/widgets/item_movie_tv_show_poster_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({Key? key}) : super(key: key);

  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => {
        context.read<NowPlayingBloc>().add(const NowPlaying(tvShows)),
        context.read<PopularBloc>().add(const Popular(tvShows)),
        context.read<TopRatedBloc>().add(const TopRated(tvShows)),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'On The Air',
              style: kHeading6,
            ),
            BlocBuilder<NowPlayingBloc, NowPlayingState>(
              builder: (context, state) {
                if (state is NowPlayingLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingHasData) {
                  return MovieTvShowPosterList(state.result, tvShows);
                } else {
                  return const Text('Failed');
                }
              },
            ),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(
                context,
                PopularPage.routeName,
                arguments: tvShows,
              ),
            ),
            BlocBuilder<PopularBloc, PopularState>(
              builder: (context, state) {
                if (state is PopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularHasData) {
                  return MovieTvShowPosterList(state.result, tvShows);
                } else {
                  return const Text('Failed');
                }
              },
            ),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(
                context,
                TopRatedPage.routeName,
                arguments: tvShows,
              ),
            ),
            BlocBuilder<TopRatedBloc, TopRatedState>(
              builder: (context, state) {
                if (state is TopRatedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedHasData) {
                  return MovieTvShowPosterList(state.result, tvShows);
                } else {
                  return const Text('Failed');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
