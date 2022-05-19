import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/common/constants.dart';
import 'package:dicoding_mfde_submission/data/models/genre_model.dart';
import 'package:dicoding_mfde_submission/data/models/movie_tv_detail_model.dart';
import 'package:dicoding_mfde_submission/data/models/movie_tv_show_model.dart';
import 'package:dicoding_mfde_submission/data/repositories/movie_tv_show_repository_impl.dart';
import 'package:dicoding_mfde_submission/common/exception.dart';
import 'package:dicoding_mfde_submission/common/failure.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/movie/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieTvShowRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    repository = MovieTvShowRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tMovieModel = MovieTvShowModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
    type: 'movie',
  );

  final tMovie = MovieTvShow(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
    type: 'movie',
  );

  final tMovieModelList = <MovieTvShowModel>[tMovieModel];
  final tMovieList = <MovieTvShow>[tMovie];

  group('Now Playing Movies', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlaying(movies))
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getNowPlaying(movies);
      // assert
      verify(mockRemoteDataSource.getNowPlaying(movies));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlaying(movies))
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlaying(movies);
      // assert
      verify(mockRemoteDataSource.getNowPlaying(movies));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlaying(movies))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlaying(movies);
      // assert
      verify(mockRemoteDataSource.getNowPlaying(movies));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Movies', () {
    test('should return movie now_playing when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopular(movies))
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getPopular(movies);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopular(movies))
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopular(movies);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopular(movies))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopular(movies);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Movies', () {
    test('should return movie now_playing when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRated(movies))
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getTopRated(movies);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRated(movies))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRated(movies);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRated(movies))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRated(movies);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Movie Detail', () {
    final tId = 1;
    final tMovieResponse = MovieTvShowDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 100,
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      imdbId: 'imdb1',
      originalLanguage: 'en',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 12000,
      runtime: 120,
      status: 'Status',
      tagline: 'Tagline',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
      type: 'movie',
    );

    test(
        'should return Movie data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getDetail(tId, movies))
          .thenAnswer((_) async => tMovieResponse);
      // act
      final result = await repository.getDetail(tId, movies);
      // assert
      verify(mockRemoteDataSource.getDetail(tId, movies));
      expect(result, equals(Right(testMovieDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getDetail(tId, movies))
          .thenThrow(ServerException());
      // act
      final result = await repository.getDetail(tId, movies);
      // assert
      verify(mockRemoteDataSource.getDetail(tId, movies));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getDetail(tId, movies))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getDetail(tId, movies);
      // assert
      verify(mockRemoteDataSource.getDetail(tId, movies));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Movie Recommendations', () {
    final tMovieList = <MovieTvShowModel>[];
    final tId = 1;

    test('should return data (movie now_playing) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getRecommendations(tId, movies))
          .thenAnswer((_) async => tMovieList);
      // act
      final result = await repository.getRecommendations(tId, movies);
      // assert
      verify(mockRemoteDataSource.getRecommendations(tId, movies));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getRecommendations(tId, movies))
          .thenThrow(ServerException());
      // act
      final result = await repository.getRecommendations(tId, movies);
      // assertbuild runner
      verify(mockRemoteDataSource.getRecommendations(tId, movies));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getRecommendations(tId, movies))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getRecommendations(tId, movies);
      // assert
      verify(mockRemoteDataSource.getRecommendations(tId, movies));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Movies', () {
    final tQuery = 'spiderman';

    test('should return movie now_playing when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.search(tQuery, movies))
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.search(tQuery, movies);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.search(tQuery, movies))
          .thenThrow(ServerException());
      // act
      final result = await repository.search(tQuery, movies);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.search(tQuery, movies))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.search(tQuery, movies);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testMovieDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testMovieDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testMovieDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testMovieDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist movies', () {
    test('should return now_playing of Movies', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieTable]);
      // act
      final result = await repository.getWatchlist();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistMovie]);
    });
  });
}
