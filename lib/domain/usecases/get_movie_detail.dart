import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_detail.dart';
import 'package:dicoding_mfde_submission/domain/repositories/movie_repository.dart';
import 'package:dicoding_mfde_submission/common/failure.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
