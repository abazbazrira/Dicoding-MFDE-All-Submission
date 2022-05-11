import 'dart:convert';

import 'package:dicoding_mfde_submission/common/constants.dart';
import 'package:dicoding_mfde_submission/data/models/movie_tv_show_model.dart';
import 'package:dicoding_mfde_submission/data/models/movie_tv_show_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tMovieModel = MovieTvShowModel(
    adult: false,
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 1,
    originalTitle: "Original Title",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    releaseDate: "2020-05-05",
    title: "Title",
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
    type: 'movie',
  );

  const tMovieResponseModel = MovieResponse(
    movieTvShowList: <MovieTvShowModel>[tMovieModel],
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/movie/now_playing.json'));
      // act
      final result = MovieResponse.fromJson(jsonMap, movies);
      // assert
      expect(result, tMovieResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tMovieResponseModel.toJson(movies);
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "/path.jpg",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "original_title": "Original Title",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "release_date": "2020-05-05",
            "title": "Title",
            "video": false,
            "vote_average": 1.0,
            "vote_count": 1,
            'type': movies
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
