import 'package:dicoding_mfde_submission/common/state_enum.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_top_rated.dart';
import 'package:flutter/foundation.dart';

class TopRatedNotifier extends ChangeNotifier {
  final GetTopRated getTopRated;

  TopRatedNotifier({required this.getTopRated});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<MovieTvShow> _movies = [];
  List<MovieTvShow> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRated(String type) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTopRated.execute(type);

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
