import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/common/constants.dart';
import 'package:dicoding_mfde_submission/common/failure.dart';
import 'package:dicoding_mfde_submission/common/state_enum.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_top_rated.dart';
import 'package:dicoding_mfde_submission/presentation/provider/top_rated_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_notifier_test.mocks.dart';

@GenerateMocks([GetTopRated])
void main() {
  late MockGetTopRated mockGetTopRatedMovies;
  late TopRatedNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedMovies = MockGetTopRated();
    notifier = TopRatedNotifier(getTopRated: mockGetTopRatedMovies)
      ..addListener(() {
        listenerCallCount++;
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

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedMovies.execute(movies))
        .thenAnswer((_) async => Right(tMovieList));
    // act
    notifier.fetchTopRated(movies);
    // assert
    expect(notifier.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetTopRatedMovies.execute(movies))
        .thenAnswer((_) async => Right(tMovieList));
    // act
    await notifier.fetchTopRated(movies);
    // assert
    expect(notifier.state, RequestState.loaded);
    expect(notifier.movies, tMovieList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedMovies.execute(movies))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRated(movies);
    // assert
    expect(notifier.state, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
