import 'package:flutter/cupertino.dart';
import 'package:jay_books/Service/database/database.dart';
import 'package:jay_books/model/book.dart';
import 'package:jay_books/model/group.dart';

class CurrentGroupState extends ChangeNotifier{
  OurGroup _currentGroup=OurGroup();
  OurBook _currentBook=OurBook();
  OurGroup get getCurrentGroup=>_currentGroup;
  OurBook get getCurrentBook=>_currentBook;
  void updateStateFromDatabase(String groupId)async{
    try{
      //TODO:get the groupInfo from firebase and get the current book info from firebase.
      _currentGroup=await OurDatabse().getGroupInfo(groupId);
      _currentBook=await OurDatabse().getCurrentBook(groupId, _currentGroup.currentBookId);
      notifyListeners();
    }catch(e){
      print(e);
    }


  }
}