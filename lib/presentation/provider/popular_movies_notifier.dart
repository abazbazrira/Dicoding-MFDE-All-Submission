import 'package:dicoding_mfde_submission/common/state_enum.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_popular_movies.dart';
import 'package:flutter/foundation.dart';

class PopularMoviesNotifier extends ChangeNotifier {
  final GetPopularMovies getPopularMovies;

  PopularMoviesNotifier(this.getPopularMovies);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<MovieTvShow> _movies = [];
  List<MovieTvShow> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopular(String type) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getPopularMovies.execute(type);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (moviesData) {
        _movies = moviesData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
