import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show_detail.dart';
import 'package:dicoding_mfde_submission/domain/repositories/movie_tv_show_repository.dart';
import 'package:dicoding_mfde_submission/common/failure.dart';

class GetDetail {
  final MovieTvShowRepository repository;

  GetDetail(this.repository);

  Future<Either<Failure, MovieTvShowDetail>> execute(int id, String type) {
    return repository.getDetail(id, type);
  }
}
