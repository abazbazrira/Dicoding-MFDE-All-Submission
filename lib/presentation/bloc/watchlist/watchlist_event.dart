part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();
}

class FetchWatchlist extends WatchlistEvent {
  const FetchWatchlist();

  @override
  List<Object?> get props => [];
}

class FetchWatchlistById extends WatchlistEvent {
  final int id;

  const FetchWatchlistById(this.id);

  @override
  List<Object?> get props => [id];
}

class AddWatchlist extends WatchlistEvent {
  final MovieTvShowDetail movie;

  const AddWatchlist(this.movie);

  @override
  List<Object?> get props => [movie];
}

class DeleteWatchlist extends WatchlistEvent {
  final MovieTvShowDetail movie;

  const DeleteWatchlist(this.movie);

  @override
  List<Object?> get props => [movie];
}
