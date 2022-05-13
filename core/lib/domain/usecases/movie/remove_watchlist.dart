import 'package:dartz/dartz.dart';

import '../../entities/movie/movie_detail.dart';
import '../../repositories/movie_repository.dart';
import '../../../utils/failure.dart';

class RemoveWatchlist {
  final MovieRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
