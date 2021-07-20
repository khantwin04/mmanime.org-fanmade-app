part of 'get_series_bloc.dart';

abstract class GetSeriesEvent extends Equatable {
  const GetSeriesEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetSeriesFetched extends GetSeriesEvent {}

class GetSeriesReload extends GetSeriesEvent {}