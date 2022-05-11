import 'package:dicoding_mfde_submission/data/models/movie_tv_show_model.dart';
import 'package:equatable/equatable.dart';

class MovieResponse extends Equatable {
  final List<MovieTvShowModel> movieTvShowList;

  const MovieResponse({required this.movieTvShowList});

  factory MovieResponse.fromJson(Map<String, dynamic> json, type) =>
      MovieResponse(
        movieTvShowList: List<MovieTvShowModel>.from((json["results"] as List)
            .map((x) => MovieTvShowModel.fromJson(x, type))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson(String type) => {
        "results":
            List<dynamic>.from(movieTvShowList.map((x) => x.toJson(type))),
      };

  @override
  List<Object> get props => [movieTvShowList];
}
