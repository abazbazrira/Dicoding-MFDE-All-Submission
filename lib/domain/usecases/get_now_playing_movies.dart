import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie.dart';
import 'package:dicoding_mfde_submission/domain/repositories/movie_repository.dart';
import 'package:dicoding_mfde_submission/common/failure.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
