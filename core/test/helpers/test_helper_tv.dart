import 'package:core/data/datasources/db/database_helper_tvls.dart';
import 'package:core/data/datasources/tv/tv_local_data_source.dart';
import 'package:core/data/datasources/tv/tv_remote_data_source.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TvRepository,
  TelevisionRemoteDataSource,
  TelevisionLocalDataSource,
  DatabaseHelperTelevision,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
