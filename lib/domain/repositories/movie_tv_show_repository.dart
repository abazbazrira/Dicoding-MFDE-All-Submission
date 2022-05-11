import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show_detail.dart';
import 'package:dicoding_mfde_submission/common/failure.dart';

abstract class MovieTvShowRepository {
  Future<Either<Failure, String>> saveWatchlist(MovieTvShowDetail movie);
  Future<Either<Failure, String>> removeWatchlist(MovieTvShowDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<MovieTvShow>>> getWatchlist();
  Future<Either<Failure, List<MovieTvShow>>> getNowPlaying(String type);
  Future<Either<Failure, List<MovieTvShow>>> getPopular(String type);
  Future<Either<Failure, List<MovieTvShow>>> getTopRated(String type);
  Future<Either<Failure, MovieTvShowDetail>> getDetail(int id, String type);
  Future<Either<Failure, List<MovieTvShow>>> getRecommendations(
      int id, String type);
  Future<Either<Failure, List<MovieTvShow>>> search(String query, String type);
}
