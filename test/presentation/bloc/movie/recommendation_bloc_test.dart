import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/common/constants.dart';
import 'package:dicoding_mfde_submission/common/failure.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_recommendations.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/recommendation/recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recommendation_bloc_test.mocks.dart';

@GenerateMocks([
  GetRecommendations,
])
void main() {
  late RecommendationBloc recommendationBloc;
  late MockGetRecommendations mockGetMovieRecommendation;

  const tId = 1;

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
    mockGetMovieRecommendation = MockGetRecommendations();
    recommendationBloc = RecommendationBloc(mockGetMovieRecommendation);
  });

  blocTest<RecommendationBloc, RecommendationState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieRecommendation.execute(tId, movies))
            .thenAnswer((_) async => Right(tMovieList));

        return recommendationBloc;
      },
      act: (bloc) => bloc.add(const Recommendation(tId, movies)),
      expect: () => [
            RecommendationLoading(),
            RecommendationHasData(tMovieList),
          ],
      verify: (_) {
        verify(mockGetMovieRecommendation.execute(tId, movies));
      });

  blocTest<RecommendationBloc, RecommendationState>(
    'Should emit [Loading, Error] when get movie detail is unsuccessful',
    build: () {
      when(mockGetMovieRecommendation.execute(tId, movies))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return recommendationBloc;
    },
    act: (bloc) => bloc.add(const Recommendation(tId, movies)),
    expect: () => [
      RecommendationLoading(),
      const RecommendationError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetMovieRecommendation.execute(tId, movies));
    },
  );
}
