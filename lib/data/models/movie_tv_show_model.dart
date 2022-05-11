import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:dicoding_mfde_submission/common/set_default_value.dart';

class MovieTvShowModel extends Equatable {
  const MovieTvShowModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.type,
  });

  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String? releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final String type;

  factory MovieTvShowModel.fromJson(Map<String, dynamic> json, type) =>
      MovieTvShowModel(
        adult: checkBoolIsNull(json["adult"]),
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalTitle: checkStringIsNull(json["original_title"]),
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: checkStringIsNull(json["title"] ?? json["name"]),
        video: checkBoolIsNull(json["video"]),
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        type: type,
      );

  Map<String, dynamic> toJson(String type) => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "type": type,
      };

  MovieTvShow toEntity() {
    return MovieTvShow(
      adult: adult,
      backdropPath: backdropPath,
      genreIds: genreIds,
      id: id,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      releaseDate: releaseDate,
      title: title,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount,
      type: type,
    );
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
        type,
      ];
}
