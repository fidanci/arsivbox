import 'package:firebase_database/firebase_database.dart';

class Tartisma {
  String _username;
  String _uid;
  String _message;

  Tartisma(this._username, this._uid, this._message);

  Tartisma.map(dynamic object) {
    this._username = object['username'];
    this._uid = object['uid'];
    this._message = object['message'];
  }

  String get username => _username;
  String get uid => _uid;
  String get message => _message;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['username'] = _username;
    map['uid'] = _uid;
    map['message'] = _message;
    return map;
  }

  Tartisma.fromDataSnapshot(DataSnapshot snapshot) {
    _uid = snapshot.key;
    _username = snapshot.value['username'];
    _message = snapshot.value['message'];
  }
}
