import 'package:arsivbox/models_json/linkjson.dart';
import 'package:arsivbox/service/apiservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'card_design/custom_card.dart';

class LinkTabJson extends StatefulWidget {
  @override
  _LinkTabJsonState createState() => _LinkTabJsonState();
}

class _LinkTabJsonState extends State<LinkTabJson> {
  ApiService service = ApiService.getInstance();
  List<LinkJson> linkList = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LinkJson>>(
      future: service.getLink(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData) {
              linkList.reversed;
              linkList = snapshot.data;
              print(linkList.toString());

              return _memoxxx();
            }
            return Center(
              child: Text('Veri yok!'),
            );

          default:
            return Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }

  Widget get _listView => AnimationLimiter(
          child: ListView.builder(
        itemCount: linkList.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 600),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: CustomCard(
                  title: linkList[index].baslik,
                  subtitle: linkList[index].aciklama,
                  link: linkList[index].link,
                  bottomSheet: bottomSheet(linkList[index].key),
                ),
              ),
            ),
          );
        },
      ));

  Widget _memoxxx() {
    return linkList.length != 0
        ? RefreshIndicator(child: _listView, onRefresh: _getData)
        : Center(child: CircularProgressIndicator());
  }

  Future<void> _getData() async {
    setState(() {
      return LinkTabJson();
    });
  }

  /*  Widget dismiss(Widget child, String key) {
    return Dismissible(
      onDismissed: (direction) async {
        // await service.removeLink(key);
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            context: context,
            builder: (context) => bottomSheet(key));
      },
      background: Container(
        color: Colors.green,
        child: Center(
          child: Text(
            'İşlem Seçin',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      key: UniqueKey(),
      child: child,
    );
  } */

  Widget bottomSheet(String key) {
    return Container(
      child: Column(
        children: <Widget>[
          Divider(
            indent: 165,
            endIndent: 165,
            thickness: 2,
            color: Colors.grey,
          ),
          _deleteCardBtn(key),
        ],
      ),
    );
  }

  Widget _deleteCardBtn(String key) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 25.0,
      ),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          await service.removeLink(key);
          Navigator.pop(context);
        },
        padding: EdgeInsets.all(15.0),
        color: Colors.red,
        child: Text(
          'Sil',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
