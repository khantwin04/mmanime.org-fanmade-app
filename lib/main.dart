import 'package:flutter/material.dart';
import 'package:flutter_app/services/bloc/movie_bloc/get_movies_bloc.dart';
import 'package:flutter_app/services/bloc/series_bloc/get_series_bloc.dart';
import 'package:flutter_app/ui/home/discover.dart';
import 'package:flutter_app/ui/home/home.dart';
import 'package:flutter_app/ui/setting/setting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/locator.dart';

void main() {
  locator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetMoviesBloc>(create: (_) => getIt.call()),
        BlocProvider<GetSeriesBloc>(create: (_) => getIt.call()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LandingScreen(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[30],
          primaryColor: Colors.white,
        ),
      ),
    );
  }
}

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

