import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinksBnb extends StatefulWidget {
  @override
  _LinksBnbState createState() => _LinksBnbState();
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _LinksBnbState extends State<LinksBnb> {
  var _firebaseRef = FirebaseDatabase().reference().child('posts');

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
          return ListView.builder(
            itemCount: item.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      title: Text(item[index]['baslik']),
                      subtitle: Text(item[index]['aciklama']),
                    ),
                    Row(
                      children: <Widget>[
                        FlatButton.icon(
                          onPressed: () => _launchURL(item[index]['link']),
                          icon: Icon(Icons.link),
                          label: Text('Linke Git'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        } else
          return Text("Yükleniyor...");
      },
    );
  }
}
