part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

class Detail extends DetailEvent {
  final int id;
  final String type;

  const Detail(this.id, this.type);

  @override
  List<Object> get props => [id, type];
}
