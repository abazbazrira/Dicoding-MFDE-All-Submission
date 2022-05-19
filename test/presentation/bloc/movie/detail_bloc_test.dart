import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/common/constants.dart';
import 'package:dicoding_mfde_submission/common/failure.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_detail.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_recommendations.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_watchlist_status.dart';
import 'package:dicoding_mfde_submission/domain/usecases/remove_watchlist.dart';
import 'package:dicoding_mfde_submission/domain/usecases/save_watchlist.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/detail/detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import 'detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetDetail,
])
void main() {
  late DetailBloc detailBloc;
  late MockGetDetail mockGetMovieDetail;

  const tId = 1;

  setUp(() {
    mockGetMovieDetail = MockGetDetail();
    detailBloc = DetailBloc(mockGetMovieDetail);
  });

  blocTest<DetailBloc, DetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieDetail.execute(tId, movies))
          .thenAnswer((_) async => const Right(testMovieDetail));

      return detailBloc;
    },
    act: (bloc) => bloc.add(const Detail(tId, movies)),
    expect: () => [
      DetailLoading(),
      const DetailHasData(testMovieDetail),
    ],
    verify: (_) {
      verify(mockGetMovieDetail.execute(tId, movies));
    }
  );

  blocTest<DetailBloc, DetailState>(
    'Should emit [Loading, Error] when get movie detail is unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(tId, movies))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return detailBloc;
    },
    act: (bloc) => bloc.add(const Detail(tId, movies)),
    expect: () => [
      DetailLoading(),
      const DetailError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetMovieDetail.execute(tId, movies));
    },
  );
}
