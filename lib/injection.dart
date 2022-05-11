import 'package:dicoding_mfde_submission/data/datasources/db/database_helper.dart';
import 'package:dicoding_mfde_submission/data/datasources/local_data_source.dart';
import 'package:dicoding_mfde_submission/data/datasources/remote_data_source.dart';
import 'package:dicoding_mfde_submission/data/repositories/movie_tv_show_repository_impl.dart';
import 'package:dicoding_mfde_submission/domain/repositories/movie_tv_show_repository.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_detail.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_recommendations.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_now_playing.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_popular_movies.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_top_rated.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_watchlist.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_watchlist_status.dart';
import 'package:dicoding_mfde_submission/domain/usecases/remove_watchlist.dart';
import 'package:dicoding_mfde_submission/domain/usecases/save_watchlist.dart';
import 'package:dicoding_mfde_submission/domain/usecases/search.dart';
import 'package:dicoding_mfde_submission/presentation/provider/detail_notifier.dart';
import 'package:dicoding_mfde_submission/presentation/provider/list_notifier.dart';
import 'package:dicoding_mfde_submission/presentation/provider/search_notifier.dart';
import 'package:dicoding_mfde_submission/presentation/provider/popular_movies_notifier.dart';
import 'package:dicoding_mfde_submission/presentation/provider/top_rated_notifier.dart';
import 'package:dicoding_mfde_submission/presentation/provider/watchlist_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => ListNotifier(
      getNowPlaying: locator(),
      getPopular: locator(),
      getTopRated: locator(),
    ),
  );
  locator.registerFactory(
    () => DetailNotifier(
      getDetail: locator(),
      getRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchNotifier(
      search: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedNotifier(
      getTopRated: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistNotifier(
      getWatchlist: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlaying(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRated(locator()));
  locator.registerLazySingleton(() => GetDetail(locator()));
  locator.registerLazySingleton(() => GetRecommendations(locator()));
  locator.registerLazySingleton(() => Search(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlist(locator()));

  // repository
  locator.registerLazySingleton<MovieTvShowRepository>(
    () => MovieTvShowRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
