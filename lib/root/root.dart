import 'package:flutter/material.dart';
import 'package:jay_books/Service/login/login.dart';
import 'package:jay_books/State/currentUserdata.dart';
import 'package:jay_books/home/home.dart';
import 'package:provider/provider.dart';
enum AuthState{
  notLoggedIn,
  LoggedIn,
}
class OurRoot extends StatefulWidget {
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthState _authState=AuthState.notLoggedIn;


  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    //getState,checkState,set AuthSate base on state
    CurrentState _currentUse=Provider.of<CurrentState>(context,listen: false);
   String returnString=await _currentUse.OnStartup();
    if(returnString=="Success"){
      setState(() {
        _authState=AuthState.LoggedIn;
      });


    }

  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;
    switch(_authState){
      case AuthState.notLoggedIn:
        retVal=OurLogin();
        break;
      case AuthState.LoggedIn:
       retVal=HomeScreen();
        break;
      default:
    }
    return retVal;
  }
}
