import 'package:flutter/material.dart';
import 'package:jay_books/Service/database/database.dart';
import 'package:jay_books/State/currentUserdata.dart';
import 'package:jay_books/Widget/OurContener.dart';
import 'package:jay_books/root/root.dart';
import 'package:provider/provider.dart';
class OurCreateGroup extends StatefulWidget {
  @override
  _OurCreateGroupState createState() => _OurCreateGroupState();
}

class _OurCreateGroupState extends State<OurCreateGroup> {

  void _createGroup(BuildContext context,String groupName)async{
CurrentState  currentState=Provider.of<CurrentState>(context,listen: false);
String returnString=await OurDatabse().CreateGroup(groupName,currentState.getCurrentUser.uid);
if(returnString=="success"){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=>OurRoot(), ), (route) => false);

}

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
                    child: Text('Create',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0,
                    ),
                    ),
                  ),
                    onPressed: ()=>_createGroup(context,_groupNameContrioller.text),
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
