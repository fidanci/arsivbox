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
              linkList = snapshot.data;
              print(linkList.toString());
              return _listView;
            }
            return Center(
              child: Text('Hata'),
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
          child: ListView.separated(
        separatorBuilder: (conext, index) => Divider(),
        itemCount: linkList.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: dismiss(
                    CustomCard(
                      title: linkList[index].baslik,
                      subtitle: linkList[index].aciklama,
                      link: linkList[index].link,
                    ),
                    linkList[index].key),
              ),
            ),
          );
        },
      ));

  Widget dismiss(Widget child, String key) {
    return Dismissible(
      onDismissed: (DismissDirection) async {
        await service.removeLink(key);
      },
      background: Container(
        color: Colors.red,
        child: Center(
          child: Text(
            'Sliniyor',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      key: UniqueKey(),
      child: child,
    );
  }
}
