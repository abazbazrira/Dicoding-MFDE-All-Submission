import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/repositories/movie_tv_show_repository.dart';
import 'package:dicoding_mfde_submission/common/failure.dart';

class GetRecommendations {
  final MovieTvShowRepository repository;

  GetRecommendations(this.repository);

  Future<Either<Failure, List<MovieTvShow>>> execute(id, type) {
    return repository.getRecommendations(id, type);
  }
}
