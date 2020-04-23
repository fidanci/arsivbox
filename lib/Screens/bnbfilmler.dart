import 'package:arsivbox/models/film.dart';
import 'package:arsivbox/service/database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FilmBnb extends StatefulWidget {
  @override
  _FilmBnbState createState() => _FilmBnbState();
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _FilmBnbState extends State<FilmBnb> {
  final DatabaseService databaseService = new DatabaseService();
  List<Film> filmler = new List();
  String filmBaslik, filmAciklama, filmLink, filmFotoLink;
  var _firebaseRef = FirebaseDatabase().reference().child('film');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firebaseRef.onValue,
      builder: (context, snap) {
        if (snap.hasData &&
            !snap.hasError &&
            snap.data.snapshot.value != null) {
          Map data = snap.data.snapshot.value;
          List item = [];
          data.forEach((index, data) => item.add({"key": index, ...data}));

          return GridView.builder(
            itemCount: item.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  _launchURL(item[index]['filmLink']);
                },
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Image(
                        image: NetworkImage(item[index]['filmFotoLink']),
                        height: 140,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    ListTile(
                      title: Text(item[index]['filmBaslik']),
                      subtitle: Text(item[index]['filmAciklama']),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        FlatButton.icon(
                          icon: Icon(Icons.personal_video),
                          label: Text('Filmi İzle'),
                          onPressed: () => _launchURL(item[index]['filmLink']),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.blue[400],
                      indent: 20,
                      endIndent: 20,
                      height: 50,
                    ),
                  ],
                ),
              );
            },
          );
        } else
          return Center(child: Text("Yükleniyor..."));
      },
    );
  }
}
