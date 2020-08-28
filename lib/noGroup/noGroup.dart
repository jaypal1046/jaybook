import 'package:flutter/material.dart';
import 'package:jay_books/Screen/createGroup/CreateGroup.dart';
import 'package:jay_books/Screen/joinGrup/joinGropup.dart';
class OurNoGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _goToJoin(BuildContext context){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> OurJoinGroup()));
    }
    void _goToCreate(BuildContext context){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> OurCreateGroup()));
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          Spacer(flex: 1,),
          Padding(
            padding: EdgeInsets.all(80.0),
            child: Image.asset("Image/jay.jpg",height: 80,width: 50,),

          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:40.0),
            child: Text("Welcome the Book Club",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35.0,
              color: Colors.grey[600]),
            ),
            ),

          Padding(
            padding: EdgeInsets.all( 20.0),
            child:   Text("Since you are not in a book club , you can select either"+
                "to join a club or create a club.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey[600],
              ),
            ),
          ),

          Spacer(flex: 1,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(child: Text('Create',),
                  onPressed: ()=>_goToCreate(context),
                  color: Theme.of(context).canvasColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Theme.of(context).secondaryHeaderColor,width: 2,),

                  ),
                ),
                RaisedButton(child: Text('Join',style: TextStyle(color: Colors.white),),
                  onPressed:()=> _goToJoin(context),
                ),

              ],
            ),
            
          ),

        ],
      ),

    );
  }
}
