import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/state_enum.dart';
import '../provider/tv/top_rated_tv_notifier.dart';
import '../widgets/tv_card_list.dart';

class TopRatedTelevisionPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  const TopRatedTelevisionPage({Key? key}) : super(key: key);

  @override
  _TopRatedTelevisionPageState createState() => _TopRatedTelevisionPageState();
}

class _TopRatedTelevisionPageState extends State<TopRatedTelevisionPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedTvNotifier>(context, listen: false)
            .fetchTopRatedTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedTvNotifier>(
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
