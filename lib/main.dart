import 'package:core/styles/text_styles.dart';
import 'package:core/styles/colors.dart';
import 'package:core/common/utils.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:about/about_page.dart';
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:core/presentation/pages/home_tv_page.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:core/presentation/pages/popular_tv_page.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:search/presentation/pages/search_page_tv.dart';
import 'package:core/presentation/pages/splash_screen.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:core/presentation/pages/top_rated_tv_page.dart';
import 'package:core/presentation/pages/tv_detail_page.dart';
import 'package:core/presentation/pages/watchlist_movies_page.dart';
import 'package:core/presentation/pages/watchlist_tv_page.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// bloc movie
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviePopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),

        /// bloc tv
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvOnAirBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvWatchlistBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: SplashScreen(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case '/tv':
              return MaterialPageRoute(builder: (_) => HomeTelevisionPage());
            case PopularTelevisionPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => PopularTelevisionPage());
            case TopRatedTelevisionPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => TopRatedTelevisionPage());
            case TelevisionDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TelevisionDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SearchTelevisionPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTelevisionPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WatchlistTelevisionPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => WatchlistTelevisionPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
