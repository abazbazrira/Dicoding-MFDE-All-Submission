import 'package:dicoding_mfde_submission/common/state_enum.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_watchlist.dart';
import 'package:flutter/foundation.dart';

class WatchlistNotifier extends ChangeNotifier {
  var _watchlistMovies = <MovieTvShow>[];
  List<MovieTvShow> get watchlistMovies => _watchlistMovies;

  var _watchlistState = RequestState.empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistNotifier({required this.getWatchlist});

  final GetWatchlist getWatchlist;

  Future<void> fetchWatchlist() async {
    _watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlist.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistState = RequestState.loaded;
        _watchlistMovies = moviesData;
        notifyListeners();
      },
    );
  }
}
