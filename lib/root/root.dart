import 'package:flutter/material.dart';
import 'package:jay_books/Service/login/login.dart';
import 'package:jay_books/SpaceScreen/SpaceScreen.dart';
import 'package:jay_books/State/currentUserdata.dart';
import 'package:jay_books/home/home.dart';
import 'package:jay_books/noGroup/noGroup.dart';
import 'package:provider/provider.dart';
enum AuthState{
  unknown,
  notLoggedIn,
  notInGroup,
  inGroup,
}
class OurRoot extends StatefulWidget {
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthState _authState=AuthState.unknown;


  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    //getState,checkState,set AuthSate base on state
    CurrentState _currentUse=Provider.of<CurrentState>(context,listen: false);
   String returnString=await _currentUse.OnStartup();
    if(returnString=="success"){
      if(_currentUse.getCurrentUser.groupId !=null){
        setState(() {
          _authState = AuthState.inGroup;
        });
      }else {
        setState(() {
          _authState = AuthState.notInGroup;
        });
      }

    }else{
      setState(() {
        _authState = AuthState.notLoggedIn;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;
    switch(_authState){
      case AuthState.unknown:
        retVal=OurSpaceScreen();
        break;
      case AuthState.notLoggedIn:
        retVal=OurLogin();
        break;
      case AuthState.notInGroup:
        retVal=OurNoGroup();
        break;
      case AuthState.inGroup:
        retVal=HomeScreen();
        break;
      default:
    }
    return retVal;
  }
}
