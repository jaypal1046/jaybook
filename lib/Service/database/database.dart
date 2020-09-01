import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jay_books/model/book.dart';
import 'package:jay_books/model/group.dart';

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
    retVal.groupId=_documentSnapshot.data['groupId'];
    }catch(e){
      print(e);
    }
    return retVal;
  }

  Future<String> CreateGroup(String groupName,String userId,OurBook initialBook) async{
    String retVal="error";
    List<String> members=List();
    try{
      members.add(userId);
      DocumentReference documentReference= await _firestore.collection("group").add({
        'name': groupName,
        'leader':userId,
        'members': members,
        'groupCreated':Timestamp.now(),

      });

      await _firestore.collection("User").document(userId).updateData({
        'groupId':documentReference.documentID,
      });

      //TODO: Add a books.
      addBook(documentReference.documentID, initialBook);
      
      retVal="success";

    }catch(e){
      print(e);
    }
    return retVal;

  }
  Future<String> JoinGroup(String groupId,String userId) async{
    String retVal="error";
    List<String> members=List();
    try{
      members.add(userId);
        await _firestore.collection("group").document(groupId).updateData({
          'members': FieldValue.arrayUnion(members),

        });
      await _firestore.collection("User").document(userId).updateData({
        'groupId':groupId,
      });
      retVal="success";

    }catch(e){
      print(e);
    }
    return retVal;

  }
  Future<OurGroup> getGroupInfo (String groupId) async{
    OurGroup retVal=OurGroup();
    try{
      DocumentSnapshot _documentSnapshot=await _firestore.collection("group").document(groupId).get();
      retVal.id=groupId;
      retVal.name=_documentSnapshot.data["name"];
      retVal.leader=_documentSnapshot.data["leader"];
      retVal.members=List<String>.from(_documentSnapshot.data["members"]);
      retVal.groupCreated=_documentSnapshot.data['groupCreated'];
      retVal.currentBookId=_documentSnapshot.data['currentBookId'];
      retVal.currentBookDue=_documentSnapshot.data['currentBookDue'];

    }catch(e){
      print(e);
    }
    return retVal;
  }
  Future<String> addBook( String groupId ,OurBook book) async{
    String retVal="error";
    try{

      DocumentReference documentReference= await _firestore.collection("group").document(groupId).collection("books").add({
        'name':book.name,
        'author':book.author,
        'length':book.length,

        'completedOn':book.dateCompleted,
      });

    //todo: add current book to group schedule
      await  _firestore.collection("group").document(groupId).updateData({
        "currentBookId":documentReference.documentID,
        "currentBookDue": book.dateCompleted,
      });
      retVal="success";

    }catch(e){
      print(e);
    }
    return retVal;

  }
  Future<OurBook> getCurrentBook (String groupId,String bookId) async{
    OurBook retVal=OurBook();
    try{
      DocumentSnapshot _documentSnapshot=
          await _firestore
          .collection("group")
          .document(groupId)
          .collection("books")
          .document(bookId)
          .get();
      retVal.id=bookId;
      retVal.name=_documentSnapshot.data["name"];
      retVal.length=_documentSnapshot.data["length"];
      retVal.author=_documentSnapshot.data["author"];
      retVal.dateCompleted=_documentSnapshot.data['dateComplete'];


    }catch(e){
      print(e);
    }
    return retVal;
  }

 }