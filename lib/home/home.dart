import 'package:flutter/material.dart';
import 'package:jay_books/State/currentUserdata.dart';
import 'package:jay_books/root/root.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('this is home '),

      ),
      body: Center(
        child: RaisedButton(child: Text('SignOut'),onPressed: ()async{
          CurrentState _currentState=Provider.of<CurrentState>(context,listen:false );
          String _returnString=await _currentState.SignOut();
          if(_returnString=="Success"){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=>OurRoot()), (route) => false);
          }
        }),
      ),
    );
  }
}
