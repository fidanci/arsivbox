import 'package:arsivbox/screenJson/add_screen/addfilmjson.dart';
import 'package:arsivbox/screenJson/add_screen/addlinkjson.dart';
import 'package:arsivbox/screenJson/filmjson.dart';
import 'package:arsivbox/screenJson/linkget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';

//drftJn1US5Y:APA91bFrL-QPh81xuJKxF6D48BucNcJrRDcRD4fIGVb0q0z4wcP9fJW99azNFq9dcbsvbiAB-SVhcs0EtZ40nf1VXycQJi27A9ambDPeNkZGwSKElvUqoFVndYobgFa1htKuGG_gFsDB

class HomeViewJson extends StatefulWidget {
  const HomeViewJson({Key key, this.user}) : super(key: key);
  final FirebaseUser user;
  @override
  _HomeViewJsonState createState() => _HomeViewJsonState();
}

class _HomeViewJsonState extends State<HomeViewJson> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  'ArşivBox',
                  style: TextStyle(
                    color: Colors.blue[400],
                  ),
                ),
                bottom: TabBar(
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(
                        Icons.link,
                        color: Colors.blue[400],
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.ondemand_video,
                        color: Colors.blue[400],
                      ),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  LinkTabJson(),
                  FilmTabJson(),
                ],
              ),
              floatingActionButton: _fabButton,
            ),
          ),
        ),
      ],
    );
  }

  Widget get _fabButton => FabCircularMenu(
        fabColor: Colors.blue[400],
        animationDuration: Duration(milliseconds: 2000),
        animationCurve: Curves.easeInOutCirc,
        ringDiameter: 240.0,
        ringWidth: 65.0,
        fabOpenIcon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        fabCloseIcon: Icon(Icons.filter_list, color: Colors.white),
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.link,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddLinkJson()));
              }),
          IconButton(
              icon: Icon(
                Icons.video_call,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddFilmJson()));
              }),
        ],
      );
}
