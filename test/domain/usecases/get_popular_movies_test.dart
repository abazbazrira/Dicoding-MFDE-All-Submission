import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/common/constants.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_populars.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopulars usecase;
  late MockMovieTvShowRepository mockMovieRpository;

  setUp(() {
    mockMovieRpository = MockMovieTvShowRepository();
    usecase = GetPopulars(mockMovieRpository);
  });

  final tMovies = <MovieTvShow>[];

  group('GetPopularMovies Tests', () {
    group('execute', () {
      test(
          'should get now_playing of movies from the repository when execute function is called',
          () async {
        // arrange
        when(mockMovieRpository.getPopular(movies))
            .thenAnswer((_) async => Right(tMovies));
        // act
        final result = await usecase.execute(movies);
        // assert
        expect(result, Right(tMovies));
      });
    });
  });
}
