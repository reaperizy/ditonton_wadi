import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/db/database_helper_tvls.dart';
import 'package:core/data/datasources/movie/movie_local_data_source.dart';
import 'package:core/data/datasources/movie/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv/tv_local_data_source.dart';
import 'package:core/data/datasources/tv/tv_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/domain/usecases/movie/get_movie_detail.dart';
import 'package:core/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movie/get_popular_movies.dart';
import 'package:core/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:core/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:core/domain/usecases/movie/get_watchlist_status.dart';
import 'package:core/domain/usecases/movie/remove_watchlist.dart';
import 'package:core/domain/usecases/movie/save_watchlist.dart';
import 'package:core/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:core/domain/usecases/tv/get_popular_tv.dart';
import 'package:core/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:core/domain/usecases/tv/get_tv_detail.dart';
import 'package:core/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:core/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:core/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:core/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:core/presentation/bloc/movie/detailmovie/detail_movie_bloc.dart';
import 'package:core/presentation/bloc/movie/nowplaying/nowplaying_movie_bloc.dart';
import 'package:core/presentation/bloc/movie/popularmovie/popular_movie_bloc.dart';
import 'package:core/presentation/bloc/movie/recommend_movie/reccomend_movie_bloc.dart';
import 'package:search/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:core/presentation/bloc/movie/toprated_movie/toprated_movie_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:core/presentation/bloc/tv/detail_tv/detail_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/onair_tv/onair_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/popular_tv/popular_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/recommend_tv/reccomend_tv_bloc.dart';
import 'package:search/presentation/bloc/search_tv/search_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/toprated_tv/toprated_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:search/domain/usecase/search_movies.dart';
import 'package:search/domain/usecase/search_tv.dart';
import 'package:core/data/datasources/sslpinning/sslpinning.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => DetailsMoviesBloc(
        getMovieDetail: locator(),
      ));
  locator.registerFactory(
    () => NowPlayingsMoviesBloc(locator()),
  );
  locator.registerFactory(
    () => PopularsMoviesBloc(locator()),
  );
  locator.registerFactory(() => RecommendMoviesBloc(
        getMovieRecommendations: locator(),
      ));
  locator.registerFactory(() => SearchMoviesBloc(
        searchMovies: locator(),
      ));
  locator.registerFactory(
    () => TopRatedsMoviesBloc(locator()),
  );
  locator.registerFactory(() => DetailsTvsBloc(
        getTvDetail: locator(),
      ));
  locator.registerFactory(
    () => OnAirsTvsBloc(locator()),
  );
  locator.registerFactory(
    () => PopularsTvsBloc(locator()),
  );
  locator.registerFactory(() => RecommendTvsBloc(
        getTvRecommendations: locator(),
      ));
  locator.registerFactory(() => SearchTvsBloc(
        searchTv: locator(),
      ));
  locator.registerFactory(
    () => TopRatedsTvsBloc(locator()),
  );
  locator.registerFactory(() => WatchlistMoviesBloc(
        getWatchlistMovies: locator(),
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator(),
      ));
  locator.registerFactory(() => WatchlistTvsBloc(
        getWatchlistTv: locator(),
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator(),
      ));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));
  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TelevisionRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TelevisionRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TelevisionLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelpertv: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperTelevision>(
      () => DatabaseHelperTelevision());

  // external
  locator.registerLazySingleton(() => SslPinnings.client);
}
