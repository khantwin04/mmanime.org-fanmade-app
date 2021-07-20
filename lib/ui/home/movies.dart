import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/api.dart';
import 'package:flutter_app/services/bloc/movie_bloc/get_movies_bloc.dart';
import 'package:flutter_app/ui/home/detail/movieDetail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Movies extends StatefulWidget {
  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  ScrollController _controller;

  String token = '';

  bool get isEnd {
    if (!_controller.hasClients) return false;
    final maxScroll = _controller.position.maxScrollExtent;
    final currentScroll = _controller.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  _scrollListener() {
    if (isEnd) {
      BlocProvider.of<GetMoviesBloc>(context).add(GetMoviesFetched());
    }
  }

  @override
  void initState() {
    _controller =
        ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMoviesBloc, GetMoviesState>(
      builder: (context, state) {
        switch (state.status) {
          case GetMoviesStatus.failure:
            return Center(
              child: Text('Failed to fetch Manga List'),
            );
          case GetMoviesStatus.success:
            if (state.movieList.isEmpty) {
              return Center(
                child: Text('No Manga'),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: GridView.builder(
                  itemCount: state.hasReachedMax
                      ? state.movieList.length
                      : state.movieList.length + 1,
                  controller: _controller,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (1 / 1.8), crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= state.movieList.length) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                height: 100,
                                color: Colors.grey[100],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Text(
                                "..Loading..",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Text(
                                '..Loading..',
                                style: TextStyle(fontWeight: FontWeight.w300),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetail(
                                  movie: state.movieList[index],
                                ),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: Hero(
                                  tag: state.movieList[index].name,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: CachedNetworkImage(
                                      imageUrl: state.movieList[index].img,
                                      placeholder: (_, __) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (_, __, ___) => Center(
                                        child: Icon(Icons.error),
                                      ),
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: double.infinity,
                                      alignment: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: double.infinity,
                                child: Text(
                                  state.movieList[index].name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }),
            );
          default:
            return Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
