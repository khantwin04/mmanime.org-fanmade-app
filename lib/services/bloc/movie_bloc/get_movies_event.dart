part of 'get_movies_bloc.dart';

abstract class GetMoviesEvent extends Equatable {
  const GetMoviesEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetMoviesFetched extends GetMoviesEvent {}

class GetMoviesReload extends GetMoviesEvent {}