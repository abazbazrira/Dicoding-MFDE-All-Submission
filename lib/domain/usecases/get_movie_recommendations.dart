import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie.dart';
import 'package:dicoding_mfde_submission/domain/repositories/movie_repository.dart';
import 'package:dicoding_mfde_submission/common/failure.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
