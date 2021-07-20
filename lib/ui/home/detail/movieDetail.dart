import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/api.dart';
import 'package:flutter_app/services/models/movie_detail_model.dart';
import 'package:flutter_app/services/models/movies_model.dart';

class MovieDetail extends StatefulWidget {
  MoviesModel movie;

  MovieDetail({this.movie});

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  Api _api;
  Future<MovieDetailModel> _detail;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _api = new Api();
    _detail = _api.getMovieDetail(widget.movie.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(widget.movie.name,),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: FutureBuilder<MovieDetailModel>(
          future: _detail,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Column(
                children: [
                  CachedNetworkImage(imageUrl: widget.movie.img, height: 200, width: 150, fit: BoxFit.cover,),
                  SizedBox(height: 10,),
                  ExpansionTile(
                    leading: Icon(Icons.file_download, color: Colors.blue,),
                    title: Text('Download Link', style: TextStyle(color: Colors.black),),
                    trailing: Text('Tap to see',style: TextStyle(color: Colors.blue),),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.size.length,
                        itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.open_in_new, color: Colors.black,),
                          title: Text(snapshot.data.size[index], style: TextStyle(color: Colors.black),),
                          trailing: Text(snapshot.data.res[index], style: TextStyle(color: Colors.black),),
                        );
                      },),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(snapshot.data.desc, style: TextStyle(color: Colors.black), textAlign: TextAlign.left,),
                ],
              );
            }else{
              return Center(child:  CircularProgressIndicator(),);
            }
          },
        ),
      ),
    );
  }
}

