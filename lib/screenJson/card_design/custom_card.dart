import 'package:arsivbox/models_json/linkjson.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String link;
  final Widget bottomSheet;

  const CustomCard(
      {Key key, this.title, this.subtitle, this.link, this.bottomSheet});

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              this.title,
            ),
            subtitle: Text(this.subtitle),
            trailing: IconButton(
                icon: Icon(Icons.expand_more),
                onPressed: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25)),
                      ),
                      context: context,
                      builder: (context) => this.bottomSheet);
                }),
          ),
          Row(
            children: <Widget>[
              FlatButton.icon(
                onPressed: () => _launchURL(this.link),
                icon: Icon(Icons.link),
                label: Text('Linke Git'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
