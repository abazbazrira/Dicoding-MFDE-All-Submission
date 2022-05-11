import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dicoding_mfde_submission/data/datasources/local_data_source.dart';
import 'package:dicoding_mfde_submission/data/datasources/remote_data_source.dart';
import 'package:dicoding_mfde_submission/data/models/movie_tv_show_table.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show_detail.dart';
import 'package:dicoding_mfde_submission/domain/repositories/movie_tv_show_repository.dart';
import 'package:dicoding_mfde_submission/common/exception.dart';
import 'package:dicoding_mfde_submission/common/failure.dart';

class MovieTvShowRepositoryImpl implements MovieTvShowRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  MovieTvShowRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, String>> saveWatchlist(MovieTvShowDetail movie) async {
    try {
      final result = await localDataSource
          .insertWatchlist(MovieTvShowTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(
      MovieTvShowDetail movie) async {
    try {
      final result = await localDataSource
          .removeWatchlist(MovieTvShowTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getMovieById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<MovieTvShow>>> getWatchlist() async {
    final result = await localDataSource.getWatchlistMovies();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<Either<Failure, List<MovieTvShow>>> getNowPlaying(String type) async {
    try {
      final result = await remoteDataSource.getNowPlaying(type);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, MovieTvShowDetail>> getDetail(
      int id, String type) async {
    try {
      final result = await remoteDataSource.getDetail(id, type);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<MovieTvShow>>> getPopular(String type) async {
    try {
      final result = await remoteDataSource.getPopular(type);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<MovieTvShow>>> getRecommendations(
      int id, String type) async {
    try {
      final result = await remoteDataSource.getRecommendations(id, type);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<MovieTvShow>>> getTopRated(String type) async {
    try {
      final result = await remoteDataSource.getTopRated(type);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
  //
  // @override
  // Future<Either<Failure, List<Movie>>> getWatchlist(String type) async {
  //   // TODO: implement getWatchlist
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<bool> isAddedToWatchlistByType(int id, String type) async {
  //   // TODO: implement isAddedToWatchlistByType
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<Either<Failure, String>> removeWatchlistByType(MovieDetail movie, String type) async {
  //   // TODO: implement removeWatchlistByType
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<Either<Failure, String>> saveWatchlistByType(MovieDetail movie, String type) async {
  //   // TODO: implement saveWatchlistByType
  //   throw UnimplementedError();
  // }

  @override
  Future<Either<Failure, List<MovieTvShow>>> search(
      String query, String type) async {
    try {
      final result = await remoteDataSource.search(query, type);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
