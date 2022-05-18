import 'package:dartz/dartz.dart';

import '../entities/tv.dart';
import '../repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';

class GetNowPlayingTv {
  final TvRepository repository;

  GetNowPlayingTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getNowPlayingTv();
  }
}