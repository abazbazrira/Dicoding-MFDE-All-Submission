import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/common/constants.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/movie/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetDetail usecase;
  late MockMovieTvShowRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieTvShowRepository();
    usecase = GetDetail(mockMovieRepository);
  });

  final tId = 1;

  test('should get movie detail from the repository', () async {
    // arrange
    when(mockMovieRepository.getDetail(tId, movies))
        .thenAnswer((_) async => Right(testMovieDetail));
    // act
    final result = await usecase.execute(tId, movies);
    // assert
    expect(result, Right(testMovieDetail));
  });
}
