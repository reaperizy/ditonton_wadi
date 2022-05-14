import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'watchlist_movies_page.dart';
import 'watchlist_tv_page.dart';
import 'home_movie_page.dart';
import '../../styles/text_styles.dart';
import '../../utils/constants.dart';
import '../../../domain/entities/tv/tv.dart';
import 'tv_detail_page.dart';
import 'popular_tv_page.dart';
import 'package:search/presentation/pages/search_page_tv.dart';
import 'top_rated_tv_page.dart';
import 'package:about/about.dart';
import 'package:core/presentation/bloc/tv/onair_tv/onair_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/popular_tv/popular_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/toprated_tv/toprated_tv_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTelevisionPage extends StatefulWidget {
  const HomeTelevisionPage({Key? key}) : super(key: key);

  @override
  _HomeTelevisionPageState createState() => _HomeTelevisionPageState();
  static const ROUTE_NAME = '/tv';
}

class _HomeTelevisionPageState extends State<HomeTelevisionPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvOnAirBloc>().add(TvOnAirGetEvent());
      context.read<TvPopularBloc>().add(TvPopularGetEvent());
      context.read<TvTopRatedBloc>().add(TvTopRatedGetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Television'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ExpansionTile(
              title: const Text('Watchlist'),
              leading: const Icon(Icons.save_alt),
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.movie),
                  title: const Text('Movie'),
                  onTap: () {
                    Navigator.pushNamed(
                        context, WatchlistMoviesPage.ROUTE_NAME);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.tv),
                  title: const Text('Television'),
                  onTap: () {
                    Navigator.pushNamed(
                        context, WatchlistTelevisionPage.ROUTE_NAME);
                  },
                ),
              ],
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTelevisionPage.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing TV',
                style: kHeading6,
              ),
              BlocBuilder<TvOnAirBloc, TvOnAirState>(
                builder: (context, state) {
                  if (state is TvOnAirLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvOnAirLoaded) {
                    return TvList(state.result);
                  } else if (state is TvOnAirError) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular TV',
                onTap: () => Navigator.pushNamed(
                    context, PopularTelevisionPage.ROUTE_NAME),
              ),
              BlocBuilder<TvPopularBloc, TvPopularState>(
                builder: (context, state) {
                  if (state is TvPopularLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvPopularLoaded) {
                    return TvList(state.result);
                  } else if (state is TvPopularError) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated TV',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTelevisionPage.ROUTE_NAME),
              ),
              BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
                builder: (context, state) {
                  if (state is TvTopRatedLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvTopRatedLoaded) {
                    return TvList(state.result);
                  } else if (state is TvTopRatedError) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tv;

  const TvList(this.tv, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvs = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TelevisionDetailPage.ROUTE_NAME,
                  arguments: tvs.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvs.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
