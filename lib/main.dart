import 'package:arsivbox/Screens/wrapper.dart';
import 'package:arsivbox/models/user.dart';
import 'package:arsivbox/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  } 
}
