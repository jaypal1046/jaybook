import 'package:flutter/material.dart';
import 'package:jay_books/State/currentUserdata.dart';
import 'package:jay_books/Widget/OurContener.dart';
import 'package:provider/provider.dart';
class SignupForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OurSignupForm();
}
class _OurSignupForm extends State<SignupForm>{
  TextEditingController _fullNameControll=TextEditingController();
  TextEditingController _emailControll=TextEditingController();
  TextEditingController _passwordControll=TextEditingController();
  TextEditingController _conformpasswordControll=TextEditingController();

  Future _signUpUser(String email, String password, BuildContext context) async {
    CurrentState _currentUser=Provider.of<CurrentState>(context,listen: false);
    try{
      if(await _currentUser.signUpUser(email, password) ){
        Navigator.pop(context);
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OurContener(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 8.0,
          ),
            child: Text('SignUp',style: TextStyle(color: Theme.of(context).secondaryHeaderColor,fontSize: 25.0,fontWeight: FontWeight.bold
            ),
            ),

          ),
          TextFormField(controller: _fullNameControll,
            decoration: InputDecoration(prefix: Icon(Icons.person),hintText: 'Full Name' ),),
          SizedBox(height: 20.0,),
          TextFormField(controller: _emailControll,
            decoration: InputDecoration(prefix: Icon(Icons.alternate_email),hintText: 'Email' ),),
          SizedBox(height: 20.0,),
          TextFormField(controller: _passwordControll,
            decoration: InputDecoration(prefix: Icon(Icons.lock_outline),hintText: 'Password' ),obscureText: true,),

          SizedBox(height: 20.0,),
          TextFormField(controller: _conformpasswordControll,
            decoration: InputDecoration(prefix: Icon(Icons.lock_open),hintText: 'Conform Password' ),obscureText: true,),
          SizedBox(height: 20.0,),

          RaisedButton(child: Padding(padding: EdgeInsets.symmetric(horizontal: 60,),
            child: Text('SignUp',style: TextStyle(color: Colors.white ,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            ),
          ),
            onPressed: (){
              if(_passwordControll.text==_conformpasswordControll.text){
                _signUpUser(_emailControll.text,_passwordControll.text,context);

              }
            },
          ),



        ],
      ),

    );
  }

}
