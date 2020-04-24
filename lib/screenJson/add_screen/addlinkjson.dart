import 'package:arsivbox/models_json/linkjson.dart';
import 'package:arsivbox/service/apiservice.dart';
import 'package:flutter/material.dart';

class AddLinkJson extends StatefulWidget {
  @override
  _AddLinkJsonState createState() => _AddLinkJsonState();
}

class _AddLinkJsonState extends State<AddLinkJson> {
  GlobalKey<FormState> formKey = GlobalKey(debugLabel: "formKey");
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerSubtitle = TextEditingController();
  TextEditingController controllerLink = TextEditingController();

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
        title: Text('Link Ekle', style: TextStyle(color: Colors.blue[400])),
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
                    labelText: "Başlık Giriniz",
                    hasFloatingPlaceholder: true,
                  ),
                  validator: this.validator,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: controllerSubtitle,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Açıklama giriniz",
                    hasFloatingPlaceholder: true,
                  ),
                  validator: this.validator,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: controllerLink,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Linki Giriniz",
                    hasFloatingPlaceholder: true,
                  ),
                  validator: this.validator,
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
          var model = LinkJson(
            baslik: controllerTitle.text.toString(),
            aciklama: controllerSubtitle.text.toString(),
            link: controllerLink.text.toString(),
          );
          await ApiService.getInstance().addLink(model);
          Navigator.pop(context);
        },
        shape: StadiumBorder(),
      );
}
