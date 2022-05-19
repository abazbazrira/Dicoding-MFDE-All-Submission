import 'dart:convert';

import 'package:dicoding_mfde_submission/common/constants.dart';
import 'package:dicoding_mfde_submission/common/exception.dart';
import 'package:dicoding_mfde_submission/data/models/movie_tv_detail_model.dart';
import 'package:dicoding_mfde_submission/data/models/movie_tv_show_model.dart';
import 'package:dicoding_mfde_submission/data/models/movie_tv_show_response.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<MovieTvShowModel>> getNowPlaying(String type);

  Future<List<MovieTvShowModel>> getPopular(String type);

  Future<List<MovieTvShowModel>> getTopRated(String type);

  Future<MovieTvShowDetailResponse> getDetail(int id, String type);

  Future<List<MovieTvShowModel>> getRecommendations(int id, String type);

  Future<List<MovieTvShowModel>> search(String query, String type);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  static const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const baseUrl = 'https://api.themoviedb.org/3';

  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieTvShowModel>> getNowPlaying(String type) async {
    final response = await client.get(
      Uri.parse(
        '$baseUrl/$type/${type == movies ? 'now_playing' : 'on_the_air'}?$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body), type)
          .movieTvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieTvShowModel>> getPopular(String type) async {
    final response =
        await client.get(Uri.parse('$baseUrl/$type/popular?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body), type)
          .movieTvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieTvShowDetailResponse> getDetail(int id, String type) async {
    final response = await client.get(Uri.parse('$baseUrl/$type/$id?$apiKey'));

    if (response.statusCode == 200) {
      return MovieTvShowDetailResponse.fromJson(
          json.decode(response.body), type);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieTvShowModel>> getRecommendations(int id, String type) async {
    final response = await client
        .get(Uri.parse('$baseUrl/$type/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body), type)
          .movieTvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieTvShowModel>> getTopRated(String type) async {
    final response =
        await client.get(Uri.parse('$baseUrl/$type/top_rated?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body), type)
          .movieTvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieTvShowModel>> search(String query, String type) async {
    final response = await client
        .get(Uri.parse('$baseUrl/search/$type?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body), type)
          .movieTvShowList;
    } else {
      throw ServerException();
    }
  }
}
