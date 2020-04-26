import 'package:arsivbox/models_json/filmjson.dart';
import 'package:arsivbox/screenJson/card_design/custom_card_film.dart';
import 'package:arsivbox/service/apiservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class FilmTabJson extends StatefulWidget {
  @override
  _FilmTabJsonState createState() => _FilmTabJsonState();
}

class _FilmTabJsonState extends State<FilmTabJson> {
  ApiService service = ApiService.getInstance();
  List<FilmJson> filmList = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FilmJson>>(
      future: service.getFilm(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData) {
              filmList = snapshot.data;
              print(filmList.toString());

              return refresh();
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

  Widget get _gridView => AnimationLimiter(
        child: GridView.count(
          crossAxisCount: 1,
          children: List.generate(filmList.length, (int index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              columnCount: 1,
              duration: const Duration(milliseconds: 375),
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: FilmCard(
                    imageUrl: filmList[index].filmFotoLink,
                    title: filmList[index].filmBaslik,
                    subtitle: filmList[index].filmAciklama,
                    link: filmList[index].filmLink,
                    bottomSheet: bottomSheet(filmList[index].key),
                  ),
                ),
              ),
            );
          }),
        ),
      );

  Widget refresh() {
    return filmList.length != 0
        ? RefreshIndicator(child: _gridView, onRefresh: _getData)
        : Center(child: CircularProgressIndicator());
  }

  Future<void> _getData() async {
    setState(() {
      return FilmTabJson();
    });
  }

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
