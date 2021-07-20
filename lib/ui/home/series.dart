import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/bloc/series_bloc/get_series_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detail/seriesDetail.dart';

class Series extends StatefulWidget {
  @override
  _SeriesState createState() => _SeriesState();
}

class _SeriesState extends State<Series> {
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
      BlocProvider.of<GetSeriesBloc>(context).add(GetSeriesFetched());
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

    return BlocBuilder<GetSeriesBloc, GetSeriesState>(
      builder: (context, state){
        switch(state.status) {
          case GetSeriesStatus.failure:
            return Center(child: Text('Failed to fetch Manga List'),);
          case GetSeriesStatus.success :
            if(state.seriesList.isEmpty){
              return Center(child: Text('No Manga'),);
            }
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: GridView.builder(
                  itemCount: state.hasReachedMax?state.seriesList.length:state.seriesList.length +1,
                  controller: _controller,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (1 / 1.8), crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    if(index >= state.seriesList.length){
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
                                style: TextStyle(fontWeight: FontWeight.w500,
                                    fontSize: 15),
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
                    }else {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SeriesDetail(
                                  series: state.seriesList[index],
                                ),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: Hero(
                                  tag: state.seriesList[index].name,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: CachedNetworkImage(
                                      imageUrl: state.seriesList[index]
                                          .img,
                                      placeholder: (_, __) =>
                                          Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                      errorWidget: (_, __, ___) =>
                                          Center(
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
                                width: double.infinity,
                                height: 50,
                                child: Text(
                                  state.seriesList[index].name,
                                  style: TextStyle(fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
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
            return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

}