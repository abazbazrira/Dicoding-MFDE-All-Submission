import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_now_playing.dart';
import 'package:dicoding_mfde_submission/common/state_enum.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_popular_movies.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_top_rated.dart';
import 'package:flutter/material.dart';

class ListNotifier extends ChangeNotifier {
  var _nowPlaying = <MovieTvShow>[];
  List<MovieTvShow> get nowPlaying => _nowPlaying;

  RequestState _nowPlayingState = RequestState.empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popular = <MovieTvShow>[];
  List<MovieTvShow> get popular => _popular;

  RequestState _popularState = RequestState.empty;
  RequestState get popularState => _popularState;

  var _topRated = <MovieTvShow>[];
  List<MovieTvShow> get topRated => _topRated;

  RequestState _topRatedState = RequestState.empty;
  RequestState get topRatedState => _topRatedState;

  String _message = '';
  String get message => _message;

  ListNotifier({
    required this.getNowPlaying,
    required this.getPopular,
    required this.getTopRated,
  });

  final GetNowPlaying getNowPlaying;
  final GetPopularMovies getPopular;
  final GetTopRated getTopRated;

  Future<void> fetchPopular(String type) async {
    _popularState = RequestState.loading;
    notifyListeners();

    final result = await getPopular.execute(type);
    result.fold(
      (failure) {
        _popularState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _popularState = RequestState.loaded;
        _popular = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchNowPlaying(String type) async {
    _nowPlayingState = RequestState.loading;
    notifyListeners();

    final result = await getNowPlaying.execute(type);
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _nowPlayingState = RequestState.loaded;
        _nowPlaying = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRated(String type) async {
    _topRatedState = RequestState.loading;
    notifyListeners();

    final result = await getTopRated.execute(type);
    result.fold(
      (failure) {
        _topRatedState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _topRatedState = RequestState.loaded;
        _topRated = moviesData;
        notifyListeners();
      },
    );
  }
}
