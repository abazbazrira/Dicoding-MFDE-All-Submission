import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/common/constants.dart';
import 'package:dicoding_mfde_submission/common/failure.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_populars.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/popular/popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_bloc_test.mocks.dart';

@GenerateMocks([
  GetPopulars,
])
void main() {
  late PopularBloc popularBloc;
  late MockGetPopulars mockGetPopulars;

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
    mockGetPopulars = MockGetPopulars();
    popularBloc = PopularBloc(mockGetPopulars);
  });

  const tId = 1;

  blocTest<PopularBloc, PopularState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopulars.execute(movies))
            .thenAnswer((_) async => Right(tMovieList));

        return popularBloc;
      },
      act: (bloc) => bloc.add(const Popular(movies)),
      expect: () => [
            PopularLoading(),
            PopularHasData(tMovieList),
          ],
      verify: (_) {
        verify(mockGetPopulars.execute(movies));
      });

  blocTest<PopularBloc, PopularState>(
    'Should emit [Loading, Error] when get movie detail is unsuccessful',
    build: () {
      when(mockGetPopulars.execute(movies))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return popularBloc;
    },
    act: (bloc) => bloc.add(const Popular(movies)),
    expect: () => [
      PopularLoading(),
      const PopularError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetPopulars.execute(movies));
    },
  );
}
