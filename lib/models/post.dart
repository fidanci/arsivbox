import 'package:firebase_database/firebase_database.dart';

class Post {
  //String _postId;
  String _baslik;
  String _aciklama;
  String _link;

  Post(this._baslik, this._aciklama, this._link);

  Post.map(dynamic object) {
    this._baslik = object['baslik'];
    this._aciklama = object['aciklama'];
    this._link = object['link'];
  }

  String get baslik => _baslik;
  String get aciklama => _aciklama;
  String get link => _link;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['baslik'] = _baslik;
    map['aciklama'] = _aciklama;
    map['link'] = _link;
    return map;
  }

  Post.fromDataSnapshot(DataSnapshot snapshot) {
   // _postId = snapshot.key;
    _baslik = snapshot.value['baslik'];
    _aciklama = snapshot.value['aciklama'];
    _link = snapshot.value['link'];
  }
}
