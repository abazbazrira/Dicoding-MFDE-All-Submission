import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/common/constants.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetRecommendations usecase;
  late MockMovieTvShowRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieTvShowRepository();
    usecase = GetRecommendations(mockMovieRepository);
  });

  final tId = 1;
  final tMovies = <MovieTvShow>[];

  test('should get now_playing of movie recommendations from the repository',
      () async {
    // arrange
    when(mockMovieRepository.getRecommendations(tId, movies))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute(tId, movies);
    // assert
    expect(result, Right(tMovies));
  });
}
