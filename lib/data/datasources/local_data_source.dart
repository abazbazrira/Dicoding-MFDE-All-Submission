import 'package:dicoding_mfde_submission/common/exception.dart';
import 'package:dicoding_mfde_submission/data/datasources/db/database_helper.dart';
import 'package:dicoding_mfde_submission/data/models/movie_tv_show_table.dart';

abstract class LocalDataSource {
  Future<String> insertWatchlist(MovieTvShowTable movie);
  Future<String> removeWatchlist(MovieTvShowTable movie);
  Future<MovieTvShowTable?> getMovieById(int id);
  Future<List<MovieTvShowTable>> getWatchlistMovies();
}

class LocalDataSourceImpl implements LocalDataSource {
  final DatabaseHelper databaseHelper;

  LocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(MovieTvShowTable movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(MovieTvShowTable movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTvShowTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTvShowTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTvShowTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => MovieTvShowTable.fromMap(data)).toList();
  }
}
