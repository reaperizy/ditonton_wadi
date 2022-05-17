// Mocks generated by Mockito 5.1.0 from annotations
// in core/test/presentation/bloc/tv/toprated_tv_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:bloc/bloc.dart' as _i9;
import 'package:core/domain/entities/tv/tv.dart' as _i8;
import 'package:core/domain/repositories/tv_repository.dart' as _i2;
import 'package:core/domain/usecases/tv/get_top_rated_tv.dart' as _i4;
import 'package:core/presentation/bloc/tv/toprated_tv/toprated_tv_bloc.dart'
    as _i5;
import 'package:core/utils/failure.dart' as _i7;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTvRepository_0 extends _i1.Fake implements _i2.TvRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

class _FakeGetTopRatedTv_2 extends _i1.Fake implements _i4.GetTopRatedTv {}

class _FakeTvTopRatedState_3 extends _i1.Fake implements _i5.TvTopRatedState {}

/// A class which mocks [GetTopRatedTv].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedTv extends _i1.Mock implements _i4.GetTopRatedTv {
  MockGetTopRatedTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository_0()) as _i2.TvRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i8.Tv>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue: Future<_i3.Either<_i7.Failure, List<_i8.Tv>>>.value(
                  _FakeEither_1<_i7.Failure, List<_i8.Tv>>()))
          as _i6.Future<_i3.Either<_i7.Failure, List<_i8.Tv>>>);
}

/// A class which mocks [TvTopRatedBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvTopRatedBloc extends _i1.Mock implements _i5.TvTopRatedBloc {
  MockTvTopRatedBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.GetTopRatedTv get getTopRatedTv =>
      (super.noSuchMethod(Invocation.getter(#getTopRatedTv),
          returnValue: _FakeGetTopRatedTv_2()) as _i4.GetTopRatedTv);
  @override
  _i5.TvTopRatedState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
          returnValue: _FakeTvTopRatedState_3()) as _i5.TvTopRatedState);
  @override
  _i6.Stream<_i5.TvTopRatedState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i5.TvTopRatedState>.empty())
          as _i6.Stream<_i5.TvTopRatedState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i5.TvTopRatedEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i5.TvTopRatedEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i5.TvTopRatedState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i5.TvTopRatedEvent>(
          _i9.EventHandler<E, _i5.TvTopRatedState>? handler,
          {_i9.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i9.Transition<_i5.TvTopRatedEvent, _i5.TvTopRatedState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i6.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  void onChange(_i9.Change<_i5.TvTopRatedState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
}