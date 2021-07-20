part of 'get_series_bloc.dart';

enum GetSeriesStatus { initial, success, failure }

class GetSeriesState extends Equatable {
  const GetSeriesState({
    this.status = GetSeriesStatus.initial,
    this.seriesList = const <SeriesModel>[],
    this.hasReachedMax = false,
  });

  final GetSeriesStatus status;
  final List<SeriesModel> seriesList;
  final bool hasReachedMax;

  GetSeriesState copyWith({
    GetSeriesStatus status,
    List<SeriesModel> seriesList,
    bool hasReachedMax,
  }) {
    return GetSeriesState(
      status: status ?? this.status,
      seriesList: seriesList ?? this.seriesList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, seriesList, hasReachedMax];
}