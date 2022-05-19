part of 'top_rated_bloc.dart';

abstract class TopRatedEvent extends Equatable {
  const TopRatedEvent();

  @override
  List<Object> get props => [];
}

class TopRated extends TopRatedEvent {
  final String type;

  const TopRated(this.type);

  @override
  List<Object> get props => [type];
}
