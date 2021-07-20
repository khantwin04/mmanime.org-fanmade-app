import 'package:flutter/material.dart';
import 'package:flutter_app/ui/home/movies.dart';
import 'package:flutter_app/ui/home/series.dart';
import 'package:flutter_app/ui/setting/setting.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _children = [
    Movies(),
    Series(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: _index,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('MM-ANIME'),
          leading: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Setting(),
                    ));
              }),
          actions: [
            IconButton(icon: Icon(Icons.search_rounded), onPressed: () {}),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.movie_creation_outlined),
              ),
              Tab(
                icon: Icon(Icons.video_collection_outlined),
              ),
            ],
            onTap: (index) {
              setState(() {
                _index = index;
              });
            },
          ),
        ),
        body: TabBarView(
          children: _children,
        ),
      ),
    );
  }
}
