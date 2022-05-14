import 'package:flutter/material.dart';

import 'package:core/common/utils.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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
    Future.microtask(() {
      context.read<TvWatchlistBloc>().add(GetListEvent());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<TvWatchlistBloc>().add(GetListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvWatchlistBloc, TvWatchlistState>(
          builder: (context, state) {
            if (state is TvWatchlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvWatchlistLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvCard(tv);
                },
                itemCount: state.result.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text("Error"),
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
