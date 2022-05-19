import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/common/constants.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/usecases/search.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late Search usecase;
  late MockMovieTvShowRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieTvShowRepository();
    usecase = Search(mockMovieRepository);
  });

  final tMovies = <MovieTvShow>[];
  final tQuery = 'Spiderman';

  test('should get now_playing of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.search(tQuery, movies))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute(tQuery, movies);
    // assert
    expect(result, Right(tMovies));
  });
}
