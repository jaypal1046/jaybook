import 'package:flutter/material.dart';
import 'package:jay_books/Screen/addBook/addBook.dart';

import 'package:jay_books/Widget/OurContener.dart';

class OurCreateGroup extends StatefulWidget {
  @override
  _OurCreateGroupState createState() => _OurCreateGroupState();
}

class _OurCreateGroupState extends State<OurCreateGroup> {

  void _goToAddBook(BuildContext context,String groupName)async{
  Navigator.push(context,
      MaterialPageRoute(builder:(context)=>
          OurAddBook(onGroupCreate: true,groupName:
          groupName,),
      )
  );
  }

  TextEditingController _groupNameContrioller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[BackButton(),],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContener(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _groupNameContrioller,
                    decoration: InputDecoration(prefixIcon: Icon(Icons.group),
                    hintText: "Group Name"
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 95),
                    child: Text('Add Book',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0,
                    ),
                    ),
                  ),
                    onPressed: ()=>_goToAddBook(context,_groupNameContrioller.text),
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
