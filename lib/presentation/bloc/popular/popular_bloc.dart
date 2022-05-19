import 'package:bloc/bloc.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_populars.dart';
import 'package:equatable/equatable.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final GetPopulars _getPopulars;

  PopularBloc(this._getPopulars) : super(PopularEmpty()) {
    on<Popular>((event, emit) async {
      final type = event.type;

      emit(PopularLoading());
      final result = await _getPopulars.execute(type);

      result.fold(
        (failure) {
          emit(PopularError(failure.message));
        },
        (data) {
          emit(PopularHasData(data));
        },
      );
    });
  }
}
