import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/common/constants.dart';
import 'package:dicoding_mfde_submission/common/failure.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_now_playing.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/now_playing/now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlaying,
])
void main() {
  late NowPlayingBloc nowPlayingBloc;
  late MockGetNowPlaying mockGetMovieNowPlaying;

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
    mockGetMovieNowPlaying = MockGetNowPlaying();
    nowPlayingBloc = NowPlayingBloc(mockGetMovieNowPlaying);
  });

  blocTest<NowPlayingBloc, NowPlayingState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieNowPlaying.execute(movies))
            .thenAnswer((_) async => Right(tMovieList));

        return nowPlayingBloc;
      },
      act: (bloc) => bloc.add(const NowPlaying(movies)),
      expect: () => [
            NowPlayingLoading(),
            NowPlayingHasData(tMovieList),
          ],
      verify: (_) {
        verify(mockGetMovieNowPlaying.execute(movies));
      });

  blocTest<NowPlayingBloc, NowPlayingState>(
    'Should emit [Loading, Error] when get movie detail is unsuccessful',
    build: () {
      when(mockGetMovieNowPlaying.execute(movies))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(const NowPlaying(movies)),
    expect: () => [
      NowPlayingLoading(),
      const NowPlayingError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetMovieNowPlaying.execute(movies));
    },
  );
}
