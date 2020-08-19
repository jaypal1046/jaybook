import 'package:flutter/material.dart';
import 'package:jay_books/Service/signup/signup.dart';
import 'package:jay_books/Widget/OurContener.dart';
class OurloginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OurContener(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 8.0,
          ),
            child: Text('Log In',style: TextStyle(color: Theme.of(context).secondaryHeaderColor,fontSize: 25.0,fontWeight: FontWeight.bold
            ),
            ),

          ),
          TextFormField(decoration: InputDecoration(prefix: Icon(Icons.alternate_email),hintText: 'Email' ),),
          SizedBox(height: 20.0,),
          TextFormField(decoration: InputDecoration(prefix: Icon(Icons.lock_outline),hintText: 'Password' ),obscureText: true,),
          SizedBox(height: 20.0,),
          RaisedButton(child: Padding(padding: EdgeInsets.symmetric(horizontal: 70,),
            child: Text('Log In',style: TextStyle(color: Colors.white ,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            ),
          ),
            onPressed: (){

            },
          ),
          FlatButton(child: Text("Don't have an Account? Sign up here"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder:
                  (context)=>OurSignupPage(),
              ),
              );
            },),


        ],
      ),

    );
  }
}
