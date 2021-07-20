import 'package:equatable/equatable.dart';
import 'package:html/dom.dart';

class MoviesModel extends Equatable{
  String name;
  String url;
  String img;

  MoviesModel({this.name, this.url, this.img});

  factory MoviesModel.toObject(Element movieElement){
    return MoviesModel(
      img: movieElement.querySelector('.image').querySelector('img').attributes['src'],
      url: movieElement.querySelector('a').attributes['href'],
      name: movieElement.querySelector('.image').querySelector('img').attributes['alt'],
    );
  }

  @override
  List<Object> get props => [name, url, img];

}