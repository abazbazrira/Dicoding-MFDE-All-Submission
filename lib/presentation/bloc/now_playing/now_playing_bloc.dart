import 'package:bloc/bloc.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_now_playing.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final GetNowPlaying _getNowPlaying;

  NowPlayingBloc(this._getNowPlaying) : super(NowPlayingEmpty()) {
    on<NowPlaying>((event, emit) async {
      final type = event.type;

      emit(NowPlayingLoading());
      final result = await _getNowPlaying.execute(type);

      result.fold(
        (failure) {
          emit(NowPlayingError(failure.message));
        },
        (data) {
          emit(NowPlayingHasData(data));
        },
      );
    });
  }
}
