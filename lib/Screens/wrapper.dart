import 'package:arsivbox/Authenticate/authenticate.dart';
import 'package:arsivbox/Screens/homepage.dart';
import 'package:arsivbox/screenJson/homejson.dart';
import 'package:arsivbox/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<User>(context);
    if(counter == null){
      return Authenticate();
    }
    else{
      return HomeViewJson();
    }
  }
}