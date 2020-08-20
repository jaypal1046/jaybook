import 'package:flutter/material.dart';
import 'package:jay_books/State/currentUserdata.dart';
import 'package:jay_books/Util/Ourthem.dart';
import 'package:jay_books/root/root.dart';


import 'Service/Login/login.dart';

import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>CurrentState (),
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Ourthem().buildTheme(),
        home: OurRoot(),
      ),
    );
  }
}

