import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/common/constants.dart';
import 'package:dicoding_mfde_submission/common/failure.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_top_rated.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/toprated/top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_bloc_test.mocks.dart';

@GenerateMocks([
  GetTopRated,
])
void main() {
  late TopRatedBloc topRatedBloc;
  late MockGetTopRated mockGetMovieTopRated;

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

  setUp(() {
    mockGetMovieTopRated = MockGetTopRated();
    topRatedBloc = TopRatedBloc(mockGetMovieTopRated);
  });

  blocTest<TopRatedBloc, TopRatedState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieTopRated.execute(movies))
            .thenAnswer((_) async => Right(tMovieList));

        return topRatedBloc;
      },
      act: (bloc) => bloc.add(const TopRated(movies)),
      expect: () => [
            TopRatedLoading(),
            TopRatedHasData(tMovieList),
          ],
      verify: (_) {
        verify(mockGetMovieTopRated.execute(movies));
      });

  blocTest<TopRatedBloc, TopRatedState>(
    'Should emit [Loading, Error] when get movie detail is unsuccessful',
    build: () {
      when(mockGetMovieTopRated.execute(movies))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const TopRated(movies)),
    expect: () => [
      TopRatedLoading(),
      const TopRatedError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetMovieTopRated.execute(movies));
    },
  );
}
