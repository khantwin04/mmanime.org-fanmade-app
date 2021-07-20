import 'package:html/dom.dart';


class SeriesDetailModel{
  String desc;
  List<String> downloadLinks;
  List<String> size;
  List<String> res;

  SeriesDetailModel({this.desc, this.downloadLinks, this.res, this.size});

  factory SeriesDetailModel.toObject(Document seriesDetail){

    var div =seriesDetail.querySelector('.contenidotv').querySelector('div').querySelectorAll('a');

    var links = div.map((e) => e.attributes['href']).toList();


    return SeriesDetailModel(
      desc: seriesDetail.querySelector('.contenidotv').querySelector('div').text,
      downloadLinks: links,
    );
  }
}