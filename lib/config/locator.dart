import 'package:flutter_app/services/api.dart';
import 'package:flutter_app/services/bloc/movie_bloc/get_movies_bloc.dart';
import 'package:flutter_app/services/bloc/series_bloc/get_series_bloc.dart';
import 'package:get_it/get_it.dart';

var getIt = GetIt.I;

void locator() {

  Api _api = Api();
  getIt.registerLazySingleton(() => _api);

  GetMoviesBloc _getMoviesBloc = GetMoviesBloc(api: getIt.call())..add(GetMoviesFetched());
  getIt.registerLazySingleton(() => _getMoviesBloc);

  GetSeriesBloc _getSeriesBloc = GetSeriesBloc(api: getIt.call())..add(GetSeriesFetched());
  getIt.registerLazySingleton(() => _getSeriesBloc);

}