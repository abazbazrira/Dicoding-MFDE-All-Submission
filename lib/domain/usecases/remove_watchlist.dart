import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/common/failure.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show_detail.dart';
import 'package:dicoding_mfde_submission/domain/repositories/movie_tv_show_repository.dart';

class RemoveWatchlist {
  final MovieTvShowRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieTvShowDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
