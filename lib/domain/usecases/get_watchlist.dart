import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/repositories/movie_tv_show_repository.dart';
import 'package:dicoding_mfde_submission/common/failure.dart';

class GetWatchlist {
  final MovieTvShowRepository _repository;

  GetWatchlist(this._repository);

  Future<Either<Failure, List<MovieTvShow>>> execute() {
    return _repository.getWatchlist();
  }
}
