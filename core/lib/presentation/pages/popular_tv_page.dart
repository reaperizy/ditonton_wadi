import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/state_enum.dart';
import '../provider/tv/popular_tv_notifier.dart';
import '../widgets/tv_card_list.dart';

class PopularTelevisionPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  const PopularTelevisionPage({Key? key}) : super(key: key);

  @override
  _PopularTelevisionPageState createState() => _PopularTelevisionPageState();
}

class _PopularTelevisionPageState extends State<PopularTelevisionPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularTvNotifier>(context, listen: false)
            .fetchPopularTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularTvNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvs = data.tv[index];
                  return TvCard(tvs);
                },
                itemCount: data.tv.length,
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
}
