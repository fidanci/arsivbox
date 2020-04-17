import 'package:arsivbox/models/user.dart';
import 'package:arsivbox/service/database.dart';
import 'package:arsivbox/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TartismaBnb extends StatefulWidget {
  @override
  _TartismaBnbState createState() => _TartismaBnbState();
}

class _TartismaBnbState extends State<TartismaBnb> {

  var _firebaseRef = FirebaseDatabase().reference().child('message');
  DatabaseService databaseService = new DatabaseService();
  final messageAlertText = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String message;
  FirebaseUser user;


  Widget _messageList(){
   return StreamBuilder(
      stream: _firebaseRef.onValue,
      builder: (context, snap){
        if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null){
          Map data = snap.data.snapshot.value;
          List item = [];
          data.forEach((index, data) => item.add({"key": index, ...data}));
          return ListView.builder(
            itemCount: item.length,
              itemBuilder: (context, index){
                return Card(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(item[index]['username']),
                            subtitle: Text(item[index]['message']),
                          ),
                        ],
                      ),
                    ),
                );
              },
          );
        };
      },
    );
  }

  Widget _messageSendTF(){
    return Row(
        children: <Widget>[
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.bottomLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            validator: (val) => val.isEmpty ? 'Boş mesaj gönderemezsiniz' : null,
            onChanged: (val){
              setState(() => message = val);
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans'
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(Icons.email, color: Colors.white,),
              hintText: 'Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    ),
          FlatButton.icon(
              onPressed: () => _messageSender(),
              icon: Icon(Icons.send, color: Colors.blue[400],),
            label: Text(''),
          ),
        ],
    );
  }

  void _messageSender(){
    message = messageAlertText.text.toString();
    databaseService.messageSave(user.uid, 'deneme' , message);
    messageAlertText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _messageList(),


        _messageSendTF(),
      ],
    );
  }
}
