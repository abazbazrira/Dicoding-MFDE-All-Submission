import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/common/constants.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_now_playing.dart';
import 'package:dicoding_mfde_submission/common/failure.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_popular_movies.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_top_rated.dart';
import 'package:dicoding_mfde_submission/presentation/provider/list_notifier.dart';
import 'package:dicoding_mfde_submission/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlaying, GetPopularMovies, GetTopRated])
void main() {
  late ListNotifier provider;
  late MockGetNowPlaying mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRated mockGetTopRatedMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingMovies = MockGetNowPlaying();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRated();
    provider = ListNotifier(
      getNowPlaying: mockGetNowPlayingMovies,
      getPopular: mockGetPopularMovies,
      getTopRated: mockGetTopRatedMovies,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tMovie = MovieTvShow(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
    type: 'movie',
  );
  final tMovieList = <MovieTvShow>[tMovie];

  void _arrangeUsecase() {
    when(mockGetNowPlayingMovies.execute(movies))
        .thenAnswer((_) async => Right(tMovieList));
    when(mockGetPopularMovies.execute(movies))
        .thenAnswer((_) async => Right(tMovieList));
    when(mockGetTopRatedMovies.execute(movies))
        .thenAnswer((_) async => Right(tMovieList));
  }

  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      // when(mockGetNowPlayingMovies.execute(movies))
      //     .thenAnswer((_) async => Right(tMovieList));
      _arrangeUsecase();
      // act
      provider.fetchNowPlaying(movies);
      // assert
      verify(mockGetNowPlayingMovies.execute(movies));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingMovies.execute(movies))
          .thenAnswer((_) async => Right(tMovieList));
      // _arrangeUsecase();
      // act
      provider.fetchNowPlaying(movies);
      // assert
      expect(provider.nowPlayingState, RequestState.loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingMovies.execute(movies))
          .thenAnswer((_) async => Right(tMovieList));
      // _arrangeUsecase();
      // act
      await provider.fetchNowPlaying(movies);
      // assert
      expect(provider.nowPlayingState, RequestState.loaded);
      expect(provider.nowPlaying, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingMovies.execute(movies))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlaying(movies);
      // assert
      expect(provider.nowPlayingState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular movies', () {
    test('should change state to loading when usecase is called', () {
      // arrange
      when(mockGetPopularMovies.execute(movies))
          .thenAnswer((_) async => Right(tMovieList));
      // _arrangeUsecase();
      // act
      provider.fetchPopular(movies);
      // assert
      expect(provider.popularState, RequestState.loading);
      // expect(listenerCallCount, 1);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularMovies.execute(movies))
          .thenAnswer((_) async => Right(tMovieList));
      // _arrangeUsecase();
      // act
      await provider.fetchPopular(movies);
      // assert
      expect(provider.popularState, RequestState.loaded);
      expect(provider.popular, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularMovies.execute(movies))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // _arrangeUsecase();
      // act
      await provider.fetchPopular(movies);
      // assert
      expect(provider.popularState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated movies', () {
    test('should change state to loading when usecase is called', () {
      // arrange
      when(mockGetTopRatedMovies.execute(movies))
          .thenAnswer((_) async => Right(tMovieList));
      // _arrangeUsecase();
      // act
      provider.fetchTopRated(movies);
      // assert
      expect(provider.topRatedState, RequestState.loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedMovies.execute(movies))
          .thenAnswer((_) async => Right(tMovieList));
      // _arrangeUsecase();
      // act
      await provider.fetchTopRated(movies);
      // assert
      expect(provider.topRatedState, RequestState.loaded);
      expect(provider.topRated, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedMovies.execute(movies))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRated(movies);
      // assert
      expect(provider.topRatedState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
