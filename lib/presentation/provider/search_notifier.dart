import 'package:dicoding_mfde_submission/common/state_enum.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/usecases/search.dart';
import 'package:flutter/foundation.dart';

class SearchNotifier extends ChangeNotifier {
  final Search search;

  SearchNotifier({required this.search});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<MovieTvShow> _searchResult = [];
  List<MovieTvShow> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchSearch(String query, String type) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await search.execute(query, type);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
