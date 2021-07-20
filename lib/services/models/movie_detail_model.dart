import 'package:html/dom.dart';

class MovieDetailModel {
  String desc;
  List<String> downloadLinks;
  List<String> size;
  List<String> res;

  MovieDetailModel({this.desc, this.downloadLinks,this.size, this.res});

  factory MovieDetailModel.toObject(Document movieDetail) {
    var desc = movieDetail.querySelector('#cap1');
    var list = desc.querySelectorAll('p');
    var concatenate = StringBuffer();

    list.forEach((item) {
      concatenate.write(item.text);
    });

    var elemento = movieDetail.querySelectorAll('.elemento').sublist(1);

    var links = elemento.map((element) {
      return element.querySelector('a').attributes['href'];
    }).toList();

    var size = elemento.map((element) {
      return element.querySelector('.c').text;
    }).toList();

    var res = elemento.map((element) {
      return element.querySelector('.d').text;
    }).toList();




    return MovieDetailModel(
      desc: concatenate.toString(),
      downloadLinks: links,
      size: size,
      res: res,
    );
  }
}
