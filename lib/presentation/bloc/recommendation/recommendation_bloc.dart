import 'package:bloc/bloc.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_event.dart';
part 'recommendation_state.dart';

class RecommendationBloc
    extends Bloc<RecommendationEvent, RecommendationState> {
  final GetRecommendations _getRecommendations;

  RecommendationBloc(this._getRecommendations) : super(RecommendationEmpty()) {
    on<Recommendation>((event, emit) async {
      final id = event.id;
      final type = event.type;

      emit(RecommendationLoading());
      final result = await _getRecommendations.execute(id, type);

      result.fold((failure) {
        emit(RecommendationError(failure.message));
      }, (data) {
        emit(RecommendationHasData(data));
      });
    });
  }
}
