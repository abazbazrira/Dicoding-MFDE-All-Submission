import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/common/failure.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/repositories/movie_tv_show_repository.dart';

class GetTopRated {
  final MovieTvShowRepository repository;

  GetTopRated(this.repository);

  Future<Either<Failure, List<MovieTvShow>>> execute(String type) {
    return repository.getTopRated(type);
  }
}
