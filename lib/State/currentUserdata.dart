import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CurrentState extends ChangeNotifier{
  String _uid;
  String _email;
  String get getUid  =>_uid;
  String get getEmail=>_email;
  FirebaseAuth _auth=FirebaseAuth.instance;
  Future<bool> signUpUser(String email,String password) async{
    bool retval=false;
    try{
      AuthResult _authResult=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if(_authResult.user!=null){
        retval=true;
      }
    }catch(e){
      print(e);
    }
    return retval;
  }
  Future<bool> logInUser( String email,String password ) async{
    bool retval=false;
    try{
      AuthResult _authResult=await _auth.signInWithEmailAndPassword(email: email, password: password);
      if(_authResult.user!=null){
        _uid=_authResult.user.uid;
        _email=_authResult.user.email;
        retval=true;
      }
    }catch(e){
      print(e);
    }
    return retval;
  }


}