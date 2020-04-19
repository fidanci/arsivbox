import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';



class TartismaBnb extends StatelessWidget {
  var _firebaseRef = FirebaseDatabase().reference().child('chats');
  TextEditingController _txtCtrl = TextEditingController();

  sendMessage() {
    _firebaseRef.push().set({
      "message": _txtCtrl.text,
      "timestamp": DateTime.now().millisecondsSinceEpoch
    });
    _txtCtrl.text = '';
  }

  deleteMessage(key) {
    _firebaseRef.child(key).remove();
  }

  updateTimeStamp(key) {
    _firebaseRef
        .child(key)
        .update({"timestamp": DateTime.now().millisecondsSinceEpoch});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FlutterOwl"),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child:
                StreamBuilder(
                  stream: _firebaseRef.onValue,
                  builder: (context, snap) {
                    
                    if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null) {
                      
                      Map data = snap.data.snapshot.value;
                      List item = [];
                      print(data);
                      data.forEach((index, data) => item.add({"key": index, ...data}));
                      print(item);
                      return ListView.builder(
                              itemCount: item.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(item[index]['message']),
                                  trailing: Text(DateFormat("hh:mm:ss")
                                      .format(DateTime.fromMicrosecondsSinceEpoch(
                                          item[index]['timestamp'] * 1000))
                                      .toString()),
                                  onTap: () =>
                                      updateTimeStamp(item[index]['key']),
                                  onLongPress: () =>
                                      deleteMessage(item[index]['key']),
                                );
                              },
                            );
                    } else
                      return Center( child: Text("No data"));
                  },
                )
              ),
              Container(
                  child: Row(children: <Widget>[
                    Expanded(child: TextField(controller: _txtCtrl)),
                    SizedBox(
                        width: 80,
                        child: OutlineButton(
                            child: Text("Add"), onPressed: () => sendMessage()))
                  ]))
            ]));
  }
}
