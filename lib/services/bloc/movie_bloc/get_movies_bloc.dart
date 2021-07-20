import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/services/api.dart';
import 'package:flutter_app/services/models/movies_model.dart';
import 'package:rxdart/rxdart.dart';

part 'get_movies_event.dart';
part 'get_movies_state.dart';

class GetMoviesBloc extends Bloc<GetMoviesEvent, GetMoviesState> {
  GetMoviesBloc({this.api}) : super(const GetMoviesState());

  final Api api;




  @override
  Stream<Transition<GetMoviesEvent, GetMoviesState>> transformEvents(
      Stream<GetMoviesEvent> events,
      TransitionFunction<GetMoviesEvent, GetMoviesState> transitionFn,
      ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<GetMoviesState> mapEventToState(GetMoviesEvent event) async* {
    if (event is GetMoviesFetched) {
      yield await _mapMovieFetchedToState(state);
    }else if (event is GetMoviesReload) {
      yield await _mapMovieFetchedToState(state.copyWith(
          movieList: [],
          hasReachedMax: false,
          status: GetMoviesStatus.initial));
    }
  }

  Future<GetMoviesState> _mapMovieFetchedToState(GetMoviesState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == GetMoviesStatus.initial) {
        final movieList = await _fetchData();
        return state.copyWith(
          status: GetMoviesStatus.success,
          movieList: movieList,
          hasReachedMax: false,
        );
      }
      final movieList = await _fetchData();
      return movieList.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
        status: GetMoviesStatus.success,
        movieList: List.of(state.movieList)..addAll(movieList),
        hasReachedMax: false,
      );
    } on Exception {
      return state.copyWith(status: GetMoviesStatus.failure);
    }
  }

  set setPage(data) => page = data;

  int page = 1;

  Future<List<MoviesModel>> _fetchData() async {
    final data = await api.getMovies(page++);
    return data;
  }
}

