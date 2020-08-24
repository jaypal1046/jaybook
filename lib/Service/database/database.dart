import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:jay_books/model/user.dart';

class OurDatabse{
  final Firestore _firestore=Firestore.instance;

  Future<String> createUser(OurUser user) async{
    String retVal="error";
    try{

      await _firestore.collection("User").document(user.uid).setData({
        'fullName':user.fullName,
        'email':user.email,
        'accountCreated':Timestamp.now(),
          });

      retVal="success";

    }catch(e){
      print(e);
    }
    return retVal;

  }
  Future<OurUser> getUserInfo (String uid) async{
    OurUser retVal=OurUser();
    try{
    DocumentSnapshot _documentSnapshot=await _firestore.collection("User").document(uid).get();
    retVal.uid=uid;
    retVal.fullName=_documentSnapshot.data["fullName"];
    retVal.email=_documentSnapshot.data["email"];
    retVal.accountCreated=_documentSnapshot.data["accountCreated"];
    }catch(e){
      print(e);
    }
    return retVal;
  }

 }