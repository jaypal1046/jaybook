import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentState extends ChangeNotifier{
  String _uid;
  String _email;
  String get getUid  =>_uid;
  String get getEmail=>_email;
  FirebaseAuth _auth=FirebaseAuth.instance;
  Future<String> signUpUser(String email,String password) async{
    String retval="error";
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      retval="success";
    }catch(e){
      retval=e.message;
    }
    return retval;
  }
  Future<String> logInUserwithEmail( String email,String password ) async{
    String retval="error";
    try{
      AuthResult _authResult=await _auth.signInWithEmailAndPassword(email: email, password: password);

        _uid=_authResult.user.uid;
        _email=_authResult.user.email;
       retval="success";

    }catch(e){
      retval=e.message;
    }
    return retval;
  }
  Future<String> logInUserWithGoogle( ) async{
    String retval='Error';
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    try{
      GoogleSignInAccount _googleUser=await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth=await _googleUser.authentication;
      final AuthCredential credential=GoogleAuthProvider.getCredential(idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);


      AuthResult _authResult=await _auth.signInWithCredential(credential);

      _uid=_authResult.user.uid;
      _email=_authResult.user.email;
      retval='success';
    }catch(e){
      retval=e.message;
    }
    return retval;
  }


}