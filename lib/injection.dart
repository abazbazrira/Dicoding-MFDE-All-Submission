import 'package:dicoding_mfde_submission/common/ssl_pinning.dart';
import 'package:dicoding_mfde_submission/data/datasources/db/database_helper.dart';
import 'package:dicoding_mfde_submission/data/datasources/local_data_source.dart';
import 'package:dicoding_mfde_submission/data/datasources/remote_data_source.dart';
import 'package:dicoding_mfde_submission/data/repositories/movie_tv_show_repository_impl.dart';
import 'package:dicoding_mfde_submission/domain/repositories/movie_tv_show_repository.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_detail.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_now_playing.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_populars.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_recommendations.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_top_rated.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_watchlist.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_watchlist_status.dart';
import 'package:dicoding_mfde_submission/domain/usecases/remove_watchlist.dart';
import 'package:dicoding_mfde_submission/domain/usecases/save_watchlist.dart';
import 'package:dicoding_mfde_submission/domain/usecases/search.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/detail/detail_bloc.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/now_playing/now_playing_bloc.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/popular/popular_bloc.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/recommendation/recommendation_bloc.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/search/search_bloc.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/toprated/top_rated_bloc.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => NowPlayingBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => DetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistBloc(
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
      getWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchBloc(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlaying(locator()));
  locator.registerLazySingleton(() => GetPopulars(locator()));
  locator.registerLazySingleton(() => GetTopRated(locator()));
  locator.registerLazySingleton(() => GetDetail(locator()));
  locator.registerLazySingleton(() => GetRecommendations(locator()));
  locator.registerLazySingleton(() => Search(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlist(locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // data sources
  locator.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(databaseHelper: locator()));

  // repository
  locator.registerLazySingleton<MovieTvShowRepository>(
    () => MovieTvShowRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => HttpSslPinning.client);
}
