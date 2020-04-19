
import 'package:arsivbox/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  DatabaseReference databaseReference;
 // StreamSubscription<Event> vtakis;
  FirebaseDatabase database = new FirebaseDatabase();
  DatabaseError error;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;

  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid,) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  static final DatabaseService _databaseService = new DatabaseService.islem();

  DatabaseService.islem();
  factory DatabaseService() {
    return _databaseService;
  }

  void initState() {
    databaseReference = database.reference().child('users');
  }

  userSave(String email, String password, String username) {
    databaseReference.push().set(<String, Object>{
      'email': email,
      'password': password,
      'username': username,
    }).then((onValue) {
      print("işlem Tamamlandı");
    }).catchError((onError) {
      print("hata var amk aha : $onError");
    });
  }

  postSave(String baslik, String aciklama, String link) {
    databaseReference = database.reference().child('posts');
    databaseReference.push().set(<String, Object>{
      'baslik': baslik,
      'aciklama': aciklama,
      'link': link,
    }).then((onValue) {
      print("işlem Tamamlandı");
    }).catchError((onError) {
      print("hata var amk aha : $onError");
    });
  }

  postList() {
    return databaseReference;
  }

  filmSave(String filmBaslik, String filmAciklama, String filmLink,
      String filmFotoLink) {
    databaseReference = database.reference().child('film');
    databaseReference.push().set(<String, Object>{
      'filmBaslik': filmBaslik,
      'filmAciklama': filmAciklama,
      'filmLink': filmLink,
      'filmFotoLink': filmFotoLink,
    }).then((onValue) {
      print('İşlem Tamam');
    }).catchError((onError) {
      print('hata var karşim filmlerde : $onError');
    });
  }

  filmList() {
    return databaseReference;
  }

  messageSend(String uid, String email, String message, String timestamp){
    databaseReference = database.reference().child('chat');
    databaseReference.push().set(<String, Object>{
      'uid' : firebaseUser.uid,
      'email' : email,
      'message' : message,
       "timestamp": DateTime.now().millisecondsSinceEpoch
    }).then((onValue){
      print('İşlem halloldu reis mesajını ilettik');
    }).catchError((onError){
      print('Güvercin hedefe ulaşamadı.... $onError');
    });
  }

  messageList(){
    return databaseReference;
  }

}
