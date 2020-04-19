import 'package:firebase_database/firebase_database.dart';

class Tartisma {
  String _email;
  String _uid;
  String _message;
  String _timestamp;

  Tartisma(this._email, this._uid, this._message, this._timestamp);

  Tartisma.map(dynamic object) {
    this._email = object['username'];
    this._uid = object['uid'];
    this._message = object['message'];
     this._timestamp = object['timestamp'];
  }

  String get email => _email;
  String get uid => _uid;
  String get message => _message;
  String get timestamp => _timestamp;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['email'] = _email;
    map['uid'] = _uid;
    map['message'] = _message;
    map['timestamp'] = _timestamp;
    return map;
  }

  Tartisma.fromDataSnapshot(DataSnapshot snapshot) {
    _uid = snapshot.key;
    _email = snapshot.value['email'];
    _message = snapshot.value['message'];
    _timestamp = snapshot.value['timestamp'];
  }
}
