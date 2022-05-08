import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie.dart';
import 'package:dicoding_mfde_submission/domain/repositories/movie_repository.dart';
import 'package:dicoding_mfde_submission/common/failure.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
