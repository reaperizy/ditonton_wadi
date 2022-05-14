import 'package:core/presentation/bloc/tv/popular_tv/popular_tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    Future.microtask(() {
      context.read<TvPopularBloc>().add(TvPopularGetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvPopularBloc, TvPopularState>(
          builder: (context, state) {
            if (state is TvPopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvPopularLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvs = state.result[index];
                  return TvCard(tvs);
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
}
