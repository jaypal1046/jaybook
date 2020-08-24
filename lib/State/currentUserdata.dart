import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jay_books/Service/database/database.dart';
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
     // _currentUser.uid=_firebaseUser.uid;
     // _currentUser.email=_firebaseUser.email;

     // retval="Success";
      _currentUser= await OurDatabse().getUserInfo(_firebaseUser.uid);
      if(_currentUser!=null){
        retval='success';
      }
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
  Future<String> signUpUser(String email,String password,String fullName) async{
    String retval="error";
    OurUser _ourUser=OurUser();
    try{
      AuthResult _authResult= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _ourUser.uid=_authResult.user.uid;
      _ourUser.email=_authResult.user.email;
      _ourUser.fullName=fullName;
      String _returnString=await OurDatabse().createUser(_ourUser);
      if(_returnString=="success"){
        retval="success";
      }
    }catch(e){
      retval=e.message;
    }
    return retval;
  }
  Future<String> logInUserwithEmail( String email,String password ) async{
    String retval="error";
    try{
      AuthResult _authResult=await _auth.signInWithEmailAndPassword(email: email, password: password);

       // _currentUser.uid=_authResult.user.uid;
       // _currentUser.email=_authResult.user.email;
      // retval="success";
      _currentUser= await OurDatabse().getUserInfo(_authResult.user.uid);
      if(_currentUser!=null){
        retval='success';
      }

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
    OurUser _user=OurUser();
    try{
      GoogleSignInAccount _googleUser=await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth=await _googleUser.authentication;
      final AuthCredential credential=GoogleAuthProvider.getCredential(idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
      AuthResult _authResult=await _auth.signInWithCredential(credential);
      if(_authResult.additionalUserInfo.isNewUser)
        {
          _user.uid=_authResult.user.uid;
          _user.email=_authResult.user.email;
          _user.fullName=_authResult.user.displayName;
          OurDatabse().createUser(_user);
        }
     // _currentUser.uid=_authResult.user.uid;
     // _currentUser.email=_authResult.user.email;

     _currentUser= await OurDatabse().getUserInfo(_authResult.user.uid);
      if(_currentUser!=null){
        retval='success';
      }
    }on PlatformException catch(e){
      retval=e.message;
    }catch(e){
      print(e);
    }
    return retval;
  }
}