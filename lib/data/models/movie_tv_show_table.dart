import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show_detail.dart';
import 'package:equatable/equatable.dart';

class MovieTvShowTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? type;

  const MovieTvShowTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.type,
  });

  factory MovieTvShowTable.fromEntity(MovieTvShowDetail movie) =>
      MovieTvShowTable(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
        type: movie.type,
      );

  factory MovieTvShowTable.fromMap(Map<String, dynamic> map) =>
      MovieTvShowTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        type: map['type'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'type': type,
      };

  MovieTvShow toEntity() => MovieTvShow.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
        type: type,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, posterPath, overview, type];
}
