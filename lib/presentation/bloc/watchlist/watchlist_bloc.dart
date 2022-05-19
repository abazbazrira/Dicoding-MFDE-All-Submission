import 'package:bloc/bloc.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show_detail.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_watchlist.dart';
import 'package:dicoding_mfde_submission/domain/usecases/get_watchlist_status.dart';
import 'package:dicoding_mfde_submission/domain/usecases/remove_watchlist.dart';
import 'package:dicoding_mfde_submission/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchlist getWatchlist;

  WatchlistBloc({
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getWatchlist,
  }) : super(WatchlistEmpty()) {
    on<FetchWatchlist>((event, emit) async {
      emit(WatchlistLoading());
      final result = await getWatchlist.execute();

      result.fold(
        (failure) async {
          emit(WatchlistError(failure.message));
        },
        (result) {
          emit(WatchlistHasData(result));
        },
      );
    });
    on<FetchWatchlistById>((event, emit) async {
      final id = event.id;

      emit(WatchlistLoading());
      final result = await getWatchListStatus.execute(id);
      final message = (result) ? 'Removed to Watchlist' : 'Added to Watchlist';
      emit(WatchlistStatusHasData(result, message));
    });
    on<AddWatchlist>((event, emit) async {
      final movie = event.movie;

      final result = await saveWatchlist.execute(movie);
      result.fold(
        (failure) async {
          emit(WatchlistError(failure.message));
        },
        (data) async {
          emit(const WatchlistStatusHasData(true, 'Removed to Watchlist'));
        },
      );
    });
    on<DeleteWatchlist>((event, emit) async {
      final movie = event.movie;

      final result = await removeWatchlist.execute(movie);
      result.fold(
        (failure) async {
          emit(WatchlistError(failure.message));
        },
        (data) async {
          emit(const WatchlistStatusHasData(false, 'Added to Watchlist'));
        },
      );
    });
  }
}
