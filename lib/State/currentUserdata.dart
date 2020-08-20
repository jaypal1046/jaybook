import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jay_books/model/user.dart';

class CurrentState extends ChangeNotifier{
  OurUser _currentUser=OurUser();

  OurUser get getCurrentUser  =>_currentUser;

  FirebaseAuth _auth=FirebaseAuth.instance;
  Future<String> OnStartup() async
  {
    String retval="error";
    try{
      FirebaseUser _firebaseUser= await _auth.currentUser();
      _currentUser.uid=_firebaseUser.uid;
      _currentUser.email=_firebaseUser.email;

      retval="Success";
    }catch(e){
      print(e);
    }
    return retval;
  }
  Future<String> SignOut() async
  {
    String retval="error";
    try{
      await _auth.signOut();
      _currentUser=OurUser();


      retval="Success";
    }catch(e){
      print(e);
    }
    return retval;
  }
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

        _currentUser.uid=_authResult.user.uid;
        _currentUser.email=_authResult.user.email;
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

      _currentUser.uid=_authResult.user.uid;
      _currentUser.email=_authResult.user.email;
      retval='success';
    }catch(e){
      retval=e.message;
    }
    return retval;
  }


}