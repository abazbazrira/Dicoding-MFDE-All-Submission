part of 'popular_bloc.dart';

abstract class PopularEvent extends Equatable {
  const PopularEvent();

  @override
  List<Object?> get props => [];
}

class Popular extends PopularEvent {
  final String type;

  const Popular(this.type);

  @override
  List<Object> get props => [type];
}
