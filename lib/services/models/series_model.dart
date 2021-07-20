import 'package:equatable/equatable.dart';
import 'package:html/dom.dart';


class SeriesModel extends Equatable{
   String img;
   String url;
   String name;

  SeriesModel({this.img, this.url, this.name});

  factory SeriesModel.toObject(Element seriesElement){
      return SeriesModel(
         img: seriesElement.querySelector('.image').querySelector('img').attributes['src'],
         url: seriesElement.querySelector('a').attributes['href'],
         name: seriesElement.querySelector('.image').querySelector('img').attributes['alt'],
      );
  }

   @override
   List<Object> get props => [name, url, img];
}
