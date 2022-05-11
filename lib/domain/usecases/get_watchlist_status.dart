import 'package:dicoding_mfde_submission/domain/repositories/movie_tv_show_repository.dart';

class GetWatchListStatus {
  final MovieTvShowRepository repository;

  GetWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
