import 'package:flutter/material.dart';
import 'package:jay_books/State/currentUserdata.dart';
import 'package:jay_books/Widget/OurContener.dart';
import 'package:jay_books/noGroup/noGroup.dart';
import 'package:jay_books/root/root.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatelessWidget {
  void _goToNoGroup(BuildContext context){
      Navigator.push(context, MaterialPageRoute(builder:(context)=>OurNoGroup()));

  }
  void _signOut(BuildContext context) async{
    CurrentState _currentState=Provider.of<CurrentState>(context,listen:false );
    String _returnString=await _currentState.SignOut();
    if(_returnString=="Success"){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=>OurRoot()), (route) => false);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(height: 40,),
          Padding(padding: const EdgeInsets.all(20.0),
            child: OurContener(
              child: Column(
                children: <Widget>[
                  Text("Harry Potter and the Sorcerer's Stone",style: TextStyle(fontSize: 25,color: Colors.grey[600]),),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:20.0),
                    child: Row(
                      children: <Widget>[
                        Text('Due In : ',style: TextStyle(fontSize: 25,color: Colors.grey[600]),),
                        Text("8 Days",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ],
              ),
              ),
          ),
          Padding(padding: const EdgeInsets.all(20.0),
            child: OurContener(child:  Padding(
              padding: const EdgeInsets.symmetric(vertical:20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Next Book Revealed In : ',style: TextStyle(fontSize: 25,color: Colors.grey[600]),),
                  Text("22 Hours",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal:40.0,vertical: 20.0),
              child: RaisedButton(child: Text('Finished Book',style: TextStyle(color: Colors.white),),
              onPressed: ()=> _goToNoGroup(context),
              ),
              ),

          Padding(padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child:RaisedButton(child: Text('SignOut'),onPressed: ()=>_signOut(context),
            color: Theme.of(context).canvasColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Theme.of(context).secondaryHeaderColor,width: 2,),

              ),

            ),

          ),
        ],
      )
    );
  }
}
