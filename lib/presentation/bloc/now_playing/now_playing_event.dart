part of 'now_playing_bloc.dart';

abstract class NowPlayingEvent extends Equatable {
  const NowPlayingEvent();

  @override
  List<Object> get props => [];
}

class NowPlaying extends NowPlayingEvent {
  final String type;

  const NowPlaying(this.type);

  @override
  List<Object> get props => [type];
}
