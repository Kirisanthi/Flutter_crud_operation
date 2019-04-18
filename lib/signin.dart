
import 'package:final_app/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => new _LoginPageState();

}

class _LoginPageState extends State<LoginPage>{
  String _email, _password;
  final GlobalKey<FormState> _formkey =GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
TextFormField(
  validator: (input){
    if(input.isEmpty){
return "Type correct name";
    }
  },
  onSaved: (input) => _email =input,
  decoration: InputDecoration(
    labelText: 'UserName'
  ),
),



TextFormField(
  validator: (input){
    if(input.length < 4){
return "Type correct password";
    }
  },

  onSaved: (input) => _password =input,
  decoration: InputDecoration(
    labelText: 'Password'
  ),
  obscureText: true,
),
RaisedButton(
  onPressed: signIn ,
  child: Text('Sign in'),
) ], ),),);}

  Future<void> signIn() async {
    
    final formState =_formkey.currentState;
    if(formState.validate()){
      formState.save();
      
      
      if(_email == "test" && _password == "test"){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      }else{
        Fluttertoast.showToast(
        msg: "Your user name or password incorrect check it",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER
        );
      }} }
}