import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/common/constants.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_now_playing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlaying usecase;
  late MockMovieTvShowRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieTvShowRepository();
    usecase = GetNowPlaying(mockMovieRepository);
  });

  final tMovies = <MovieTvShow>[];

  test('should get now_playing of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.getNowPlaying(movies))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute(movies);
    // assert
    expect(result, Right(tMovies));
  });
}
