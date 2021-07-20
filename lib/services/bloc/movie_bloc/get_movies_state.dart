part of 'get_movies_bloc.dart';

enum GetMoviesStatus { initial, success, failure }

class GetMoviesState extends Equatable {
  const GetMoviesState({
    this.status = GetMoviesStatus.initial,
    this.movieList = const <MoviesModel>[],
    this.hasReachedMax = false,
  });

  final GetMoviesStatus status;
  final List<MoviesModel> movieList;
  final bool hasReachedMax;

  GetMoviesState copyWith({
    GetMoviesStatus status,
    List<MoviesModel> movieList,
    bool hasReachedMax,
  }) {
    return GetMoviesState(
      status: status ?? this.status,
      movieList: movieList ?? this.movieList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, movieList, hasReachedMax];
}

