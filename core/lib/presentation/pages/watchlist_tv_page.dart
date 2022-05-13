import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:core/common/utils.dart';
import 'package:core/presentation/provider/tv/watchlist_tv_notifier.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:core/utils/state_enum.dart';

class WatchlistTelevisionPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  const WatchlistTelevisionPage({Key? key}) : super(key: key);

  @override
  _WatchlistTelevisionPageState createState() =>
      _WatchlistTelevisionPageState();
}

class _WatchlistTelevisionPageState extends State<WatchlistTelevisionPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistTvNotifier>(context, listen: false)
            .fetchWatchlistTv());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistTvNotifier>(context, listen: false).fetchWatchlistTv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<WatchlistTvNotifier>(
          builder: (context, data, child) {
            if (data.watchlistTvState == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistTvState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.watchlistTv[index];
                  return TvCard(tv);
                },
                itemCount: data.watchlistTv.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
