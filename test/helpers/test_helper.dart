import 'package:dicoding_mfde_submission/data/datasources/db/database_helper.dart';
import 'package:dicoding_mfde_submission/data/datasources/local_data_source.dart';
import 'package:dicoding_mfde_submission/data/datasources/remote_data_source.dart';
import 'package:dicoding_mfde_submission/domain/repositories/movie_tv_show_repository.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieTvShowRepository,
  RemoteDataSource,
  LocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
