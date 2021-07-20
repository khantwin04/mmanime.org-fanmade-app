import 'package:flutter_app/config/constant.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart';
import 'package:html/parser.dart';

import 'models/movie_detail_model.dart';
import 'models/movies_model.dart';
import 'models/series_detail_model.dart';
import 'models/series_model.dart';

class Api {

  Future<List<SeriesModel>> getSeries(int page) async {
    http.Response response = await http.get(Uri.parse("${Constant.surl}/page/${page}"));
    Document document = parse(response.body);
    var items = document.querySelector('.items').querySelectorAll('.item');
    return items.map((element) => SeriesModel.toObject(element)).toList();
  }

  Future<List<MoviesModel>> getMovies(int page) async {
    http.Response response = await http.get(Uri.parse("${Constant.url}/page/${page}"));
    Document document = parse(response.body);
    var items = document.querySelector('.items').querySelectorAll('.item');
    return items.map((element) => MoviesModel.toObject(element)).toList();
  }

  Future<SeriesDetailModel> getSeriesDetail(String url) async{
    http.Response response = await http.get(Uri.parse(url));
    Document document = parse(response.body);
    return SeriesDetailModel.toObject(document);
  }

  Future<MovieDetailModel> getMovieDetail(String url) async{
    http.Response response = await http.get(Uri.parse(url));
    Document document = parse(response.body);
    return MovieDetailModel.toObject(document);
  }


}