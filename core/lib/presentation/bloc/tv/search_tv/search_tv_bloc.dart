import 'package:core/domain/entities/tv/tv.dart';
import 'package:search/domain/usecase/search_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTv searchTv;

  TvSearchBloc({
    required this.searchTv,
  }) : super(TvSearchEmpty()) {
    on<TvSearchSetEmpty>((event, emit) => emit(TvSearchEmpty()));

    on<TvSearchQueryEvent>((event, emit) async {
      emit(TvSearchLoading());
      final result = await searchTv.execute(event.query);
      result.fold(
        (failure) {
          emit(TvSearchError(failure.message));
        },
        (data) {
          emit(TvSearchLoaded(data));
        },
      );
    });
  }
}
