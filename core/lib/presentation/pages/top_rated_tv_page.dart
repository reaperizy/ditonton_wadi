import 'package:core/presentation/bloc/tv/toprated_tv/toprated_tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    Future.microtask(() {
      context.read<TvTopRatedBloc>().add(TvTopRatedGetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
          builder: (context, state) {
            if (state is TvTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvTopRatedLoaded) {
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
