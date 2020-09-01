import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:jay_books/Service/database/database.dart';
import 'package:jay_books/State/currentUserdata.dart';
import 'package:jay_books/Widget/OurContener.dart';
import 'package:jay_books/model/book.dart';
import 'package:jay_books/root/root.dart';
import 'package:provider/provider.dart';
class OurAddBook extends StatefulWidget {
   final bool onGroupCreate;
   final String groupName;
   OurAddBook({
     this.onGroupCreate,
     this.groupName,
   });
  @override
  _OurAddBookState createState() => _OurAddBookState();
}

class _OurAddBookState extends State<OurAddBook> {
  TextEditingController _bookNameController=TextEditingController();
  TextEditingController _authorController=TextEditingController();
  TextEditingController _lengthController=TextEditingController();
  DateTime _selectDate=DateTime.now();
  Future<void> _selectedDate (BuildContext context)async{
    final DateTime picker=await DatePicker.showDateTimePicker(context,showTitleActions:true);
    if(picker !=null && picker!=_selectDate ){
      setState(() {

        _selectDate=picker;

      });
    }else{
      setState(() {
        _selectDate=_selectDate;
      });
    }
  }

  void _addBook(BuildContext context,String groupName,OurBook ourBook)async{
    CurrentState  currentState=Provider.of<CurrentState>(context,listen: false);
    String returnString;
    if(widget.onGroupCreate){
      returnString==
          await OurDatabse().CreateGroup(groupName,currentState.getCurrentUser.uid,ourBook);
    }
    else{

     returnString=await OurDatabse().addBook(currentState.getCurrentUser.groupId,ourBook);
    }


    if(returnString=="success"){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=>OurRoot(), ), (route) => false);

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[BackButton(),],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContener(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _bookNameController,
                    decoration: InputDecoration(prefixIcon: Icon(Icons.group),
                        hintText: "Book Name"
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _authorController,
                    decoration: InputDecoration(prefixIcon: Icon(Icons.group),
                        hintText: "Author"
                    ),

                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _lengthController,
                    decoration: InputDecoration(prefixIcon: Icon(Icons.group),
                        hintText: "Length",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //todo:: date picker...
                  Text(DateFormat.yMMMMd("en_US").format(_selectDate)),
                  Text(DateFormat("H:mm").format(_selectDate)),
                //  Text(_selectDate.hour.toString()+":"+_selectDate.minute.toString()+_selectDate.second.toString().trim()),
                  FlatButton(onPressed:
                      ()=>_selectedDate(context),
                    child: Text("Change Date"),
                  ),

                  RaisedButton(child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 95),
                    child: Text('Create',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0,
                    ),
                    ),
                  ),
                    onPressed: (){ OurBook book=OurBook();
                    book.name=_bookNameController.text;
                    book.author=_authorController.text;
                    book.length=int.parse(_lengthController.text);
                    book.dateCompleted=Timestamp.fromDate(_selectDate);

                      _addBook(context,widget.groupName,book);


                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
}
