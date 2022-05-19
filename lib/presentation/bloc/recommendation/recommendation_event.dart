part of 'recommendation_bloc.dart';

abstract class RecommendationEvent extends Equatable {
  const RecommendationEvent();
}

class Recommendation extends RecommendationEvent {
  final int id;
  final String type;

  const Recommendation(this.id, this.type);

  @override
  List<Object?> get props => [id, type];
}
