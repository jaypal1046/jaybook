import 'package:flutter/material.dart';
import 'package:jay_books/Service/login/loginform.dart';
class OurLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Image.asset('Image/jay.jpg'),
                ),
                SizedBox(height: 30,),
                OurloginForm(),
              ],

            ),
          ),
        ],
      ),
    );
  }
}
