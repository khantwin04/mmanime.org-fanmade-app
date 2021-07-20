import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/services/api.dart';
import 'package:flutter_app/services/models/series_detail_model.dart';
import 'package:flutter_app/services/models/series_model.dart';


class SeriesDetail extends StatefulWidget {
  SeriesModel series;
  SeriesDetail({this.series});

  @override
  _SeriesDetailState createState() => _SeriesDetailState();
}

class _SeriesDetailState extends State<SeriesDetail> {

  Api _api;
  Future<SeriesDetailModel> _detail;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _api = new Api();
    _detail = _api.getSeriesDetail(widget.series.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(widget.series.name,),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: FutureBuilder<SeriesDetailModel>(
          future: _detail,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Column(
                children: [
                  CachedNetworkImage(imageUrl: widget.series.img, height: 200, width: 150, fit: BoxFit.cover,),
                  SizedBox(height: 10,),
                  ExpansionTile(
                    leading: Icon(Icons.file_download, color: Colors.blue,),
                    title: Text('Download Link', style: TextStyle(color: Colors.black),),
                    trailing: Text('Tap to see',style: TextStyle(color: Colors.blue),),
                    children: [
                      Container(
                        height: 200,
                        child: ListView.builder(
                          //shrinkWrap: true,
                          itemCount: snapshot.data.downloadLinks.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Icon(Icons.open_in_new, color: Colors.black,),
                              title: Text(snapshot.data.downloadLinks[index], style: TextStyle(color: Colors.black),),
                            );
                          },),
                      ),
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
