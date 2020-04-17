import 'package:firebase_database/firebase_database.dart';

class Film {
  String _filmBaslik;
  String _filmAciklama;
  String _filmLink;
  String _filmFotoLink;

  Film( this._filmBaslik, this._filmAciklama, this._filmLink, this._filmFotoLink);

  Film.map(dynamic object){
    this._filmBaslik = object['filmBaslik'];
    this._filmAciklama = object['filmAciklama'];
    this._filmLink = object['filmLink'];
    this._filmFotoLink = object['filmFotoLink'];
  }

  String get filmBaslik => _filmBaslik;
  String get filmAciklama => _filmAciklama;
  String get filmLink => _filmLink;
  String get filmFotoLink => _filmFotoLink;

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['filmBaslik'] = _filmBaslik;
    map['filmAciklama'] = _filmAciklama;
    map['filmLink'] = _filmLink;
    map['filmFotoLink'] = _filmFotoLink;
    return map;
  }

  Film.fromDataSnapshot(DataSnapshot snapshot){
    _filmBaslik = snapshot.value['filmBaslik'];
    _filmAciklama = snapshot.value['filmAciklama'];
    _filmLink = snapshot.value['filmLink'];
    _filmFotoLink = snapshot.value['filmFotoLink'];
  }
}
