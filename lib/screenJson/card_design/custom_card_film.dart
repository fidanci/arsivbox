import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FilmCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String link;
  final Widget bottomSheet;

  const FilmCard(
      {Key key,
      this.imageUrl,
      this.title,
      this.subtitle,
      this.link,
      this.bottomSheet});

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
          Expanded(
            child: Image(
              image: NetworkImage(this.imageUrl),
              height: 100,
              fit: BoxFit.fitWidth,
            ),
          ),
          ListTile(
            title: Text(this.title),
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
                }
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.personal_video),
                label: Text('Filmi İzle'),
                onPressed: () => _launchURL(this.link),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}
