import 'package:bloc/bloc.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show_detail.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_detail.dart';
import 'package:equatable/equatable.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetDetail _getDetail;

  DetailBloc(this._getDetail) : super(DetailEmpty()) {
    on<Detail>((event, emit) async {
      final id = event.id;
      final type = event.type;

      emit(DetailLoading());
      final result = await _getDetail.execute(id, type);

      result.fold(
        (failure) {
          emit(DetailError(failure.message));
        },
        (data) {
          emit(DetailHasData(data));
        },
      );
    });
  }
}
