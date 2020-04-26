import 'package:arsivbox/models_json/filmjson.dart';
import 'package:arsivbox/service/apiservice.dart';
import 'package:flutter/material.dart';

class AddFilmJson extends StatefulWidget {
  @override
  _AddFilmJsonState createState() => _AddFilmJsonState();
}

class _AddFilmJsonState extends State<AddFilmJson> {
  GlobalKey<FormState> formKey = GlobalKey(debugLabel: "formKey");
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerSubtitle = TextEditingController();
  TextEditingController controllerLink = TextEditingController();
  TextEditingController controllerImageLink = TextEditingController();

  String validator(val) {
    if (val.isEmpty) {
      return "Bu alan boş geçilemez";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Film Ekle', style: TextStyle(color: Colors.blue[400])),
      ),
      body: Form(
        key: formKey,
        autovalidate: true,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: controllerTitle,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Image Url giriniz...",
                    hasFloatingPlaceholder: true,
                  ),
                  validator: this.validator,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: controllerTitle,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Film adını giriniz...",
                    hasFloatingPlaceholder: true,
                  ),
                  validator: this.validator,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: controllerTitle,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Film açıklamasını giriniz...",
                    hasFloatingPlaceholder: true,
                  ),
                  validator: this.validator,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: controllerTitle,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Film'in linkini giriniz...",
                    hasFloatingPlaceholder: true,
                  ),
                  validator: this.validator,
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _fabButton,
    );
  }

  Widget get _fabButton => FloatingActionButton(
      child: Icon(Icons.save),
      onPressed: () async {
        var model = FilmJson(
          filmFotoLink: controllerImageLink.text.toString(),
          filmBaslik: controllerTitle.text.toString(),
          filmAciklama: controllerSubtitle.text.toString(),
          filmLink: controllerLink.text.toString(),
        );
        await ApiService.getInstance().addFilm(model);
        Navigator.pop(context);
      });
}
