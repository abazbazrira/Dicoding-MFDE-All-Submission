import 'package:bloc/bloc.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_top_rated.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final GetTopRated _getTopRated;

  TopRatedBloc(this._getTopRated) : super(TopRatedEmpty()) {
    on<TopRated>((event, emit) async {
      final type = event.type;

      emit(TopRatedLoading());
      final result = await _getTopRated.execute(type);

      result.fold(
        (failure) {
          emit(TopRatedError(failure.message));
        },
        (data) {
          emit(TopRatedHasData(data));
        },
      );
    });
  }
}
