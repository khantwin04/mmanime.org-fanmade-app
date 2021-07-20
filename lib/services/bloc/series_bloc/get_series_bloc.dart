import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/services/api.dart';
import 'package:flutter_app/services/models/series_model.dart';
import 'package:rxdart/rxdart.dart';

part 'get_series_event.dart';
part 'get_series_state.dart';

class GetSeriesBloc extends Bloc<GetSeriesEvent, GetSeriesState> {
  GetSeriesBloc({this.api}) : super(const GetSeriesState());

  final Api api;

  @override
  Stream<Transition<GetSeriesEvent, GetSeriesState>> transformEvents(
      Stream<GetSeriesEvent> events,
      TransitionFunction<GetSeriesEvent, GetSeriesState> transitionFn,
      ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<GetSeriesState> mapEventToState(GetSeriesEvent event) async* {
    if (event is GetSeriesFetched) {
      yield await _mapSeriesFetchedToState(state);
    }else if (event is GetSeriesReload) {
      yield await _mapSeriesFetchedToState(state.copyWith(
          seriesList: [],
          hasReachedMax: false,
          status: GetSeriesStatus.initial));
    }
  }

  Future<GetSeriesState> _mapSeriesFetchedToState(GetSeriesState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == GetSeriesStatus.initial) {
        final seriesList = await _fetchData();
        return state.copyWith(
          status: GetSeriesStatus.success,
          seriesList: seriesList,
          hasReachedMax: false,
        );
      }
      final seriesList = await _fetchData();
      return seriesList.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
        status: GetSeriesStatus.success,
        seriesList: List.of(state.seriesList)..addAll(seriesList),
        hasReachedMax: false,
      );
    } on Exception {
      return state.copyWith(status: GetSeriesStatus.failure);
    }
  }

  set setPage(data) => page = data;

  int page = 1;

  Future<List<SeriesModel>> _fetchData() async {
    final data = await api.getSeries(page++);
    return data;
  }
}

