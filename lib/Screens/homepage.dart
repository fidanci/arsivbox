import 'package:arsivbox/Screens/bnbfilmler.dart';
import 'package:arsivbox/Screens/bnblinks.dart';
import 'package:arsivbox/Screens/bnbtartisma.dart';
import 'package:arsivbox/models/post.dart';
import 'package:arsivbox/service/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.user}) : super(key: key);
  final FirebaseUser user;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService databaseService = new DatabaseService();
  List<Post> posts = new List();
  final formKontrol = GlobalKey<FormState>();
  final baslikAlertText = TextEditingController();
  final aciklamaAlertText = TextEditingController();
  final linkAlertText = TextEditingController();
  final fotoLinkAletText = TextEditingController();

  String baslik, aciklama, link, fotoLink;
  String appBarTitle = 'ArşivBox';


  void addScreen() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Link Ekle',
            style: TextStyle(color: Colors.blue[400]),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Form(
                  key: formKontrol,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: baslikAlertText,
                        decoration: InputDecoration(hintText: 'Başlık'),
                      ),
                      TextFormField(
                        controller: aciklamaAlertText,
                        decoration: InputDecoration(hintText: 'Açıklama'),
                      ),
                      TextFormField(
                        controller: linkAlertText,
                        decoration: InputDecoration(hintText: 'Link'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: _linkAdd,
                child: Text(
                  'Link Ekle',
                  style: TextStyle(color: Colors.blue[400]),
                )),
            FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'İptal',
                  style: TextStyle(color: Colors.blue[400]),
                ))
          ],
        );
      },
    );
  }

  _linkAdd() {
    baslik = baslikAlertText.text.toString();
    aciklama = aciklamaAlertText.text.toString();
    link = linkAlertText.text.toString();
    databaseService.postSave(baslik, aciklama, link);
    baslikAlertText.clear();
    aciklamaAlertText.clear();
    linkAlertText.clear();
    Navigator.pop(context);
  }

  void filmAddScreen() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Film Ekle',
            style: TextStyle(color: Colors.blue[400]),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Form(
                  key: formKontrol,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: baslikAlertText,
                        decoration: InputDecoration(hintText: 'Başlık'),
                      ),
                      TextFormField(
                        controller: aciklamaAlertText,
                        decoration: InputDecoration(hintText: 'Açıklama'),
                      ),
                      TextFormField(
                        controller: linkAlertText,
                        decoration: InputDecoration(hintText: 'Film Link'),
                      ),
                      TextFormField(
                        controller: fotoLinkAletText,
                        decoration: InputDecoration(hintText: 'Foto Link'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: _filmAdd,
                child: Text(
                  'Film Ekle',
                  style: TextStyle(color: Colors.blue[400]),
                )),
            FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'İptal',
                  style: TextStyle(color: Colors.blue[400]),
                ))
          ],
        );
      },
    );
  }

  _filmAdd() {
    baslik = baslikAlertText.text.toString();
    aciklama = aciklamaAlertText.text.toString();
    link = linkAlertText.text.toString();
    fotoLink = fotoLinkAletText.text.toString();
    databaseService.filmSave(baslik, aciklama, link, fotoLink);
    baslikAlertText.clear();
    aciklamaAlertText.clear();
    linkAlertText.clear();
    fotoLinkAletText.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  appBarTitle,
                  style: TextStyle(
                    color: Colors.blue[400],
                  ),
                ),
                actions: <Widget>[
                  FlatButton.icon(
                    onPressed: () async {
                      addScreen();
                    },
                    icon: Icon(
                      Icons.note_add,
                      color: Colors.blue[400],
                    ),
                    label: Text('Link'),
                  ),
                  FlatButton.icon(
                    onPressed: () async {
                      filmAddScreen();
                    },
                    icon: Icon(
                      Icons.video_call,
                      color: Colors.blue[400],
                    ),
                    label: Text('Film'),
                  ),
                ],
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
                    Tab(
                      icon: Icon(
                        Icons.chat,
                        color: Colors.blue[400],
                      ),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  LinksBnb(),
                  FilmBnb(),
                  TartismaBnb(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
