import 'package:tvseries/data/datasources/db/database_helper_tvls.dart';
import 'package:tvseries/data/datasources/tv_local_data_source.dart';
import 'package:tvseries/data/datasources/tv_remote_data_source.dart';
import 'package:tvseries/domain/repositories/tv_repository.dart';
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
