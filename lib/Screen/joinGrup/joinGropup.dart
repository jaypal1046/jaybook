import 'package:flutter/material.dart';
import 'package:jay_books/Service/database/database.dart';
import 'package:jay_books/State/currentUserdata.dart';
import 'package:jay_books/Widget/OurContener.dart';
import 'package:jay_books/root/root.dart';
import 'package:provider/provider.dart';
class OurJoinGroup extends StatefulWidget {
  @override
  _OurJoinGroupState createState() => _OurJoinGroupState();
}

class _OurJoinGroupState extends State<OurJoinGroup> {
  void _joinGroup(BuildContext context,String groupId)async{
    CurrentState  currentState=Provider.of<CurrentState>(context,listen: false);
    String returnString=await OurDatabse().JoinGroup(groupId,currentState.getCurrentUser.uid);
    if(returnString=="success"){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=>OurRoot(), ), (route) => false);

    }else{
      print('jaypal');
    }

  }
  TextEditingController _groupIdContrioller=TextEditingController();
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
                    controller: _groupIdContrioller,
                    decoration: InputDecoration(prefixIcon: Icon(Icons.group),
                        hintText: "Group id"
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 95),
                    child: Text('Join',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0,
                    ),
                    ),
                  ),
                    onPressed: ()=>_joinGroup(context,_groupIdContrioller.text),
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
