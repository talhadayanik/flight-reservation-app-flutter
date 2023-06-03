import 'package:flight_reservation/Screens/Homepage_Member.dart';
import 'package:flutter/material.dart';
import 'package:flight_reservation/main.dart';
import 'package:http/http.dart' as http;
import 'package:flight_reservation/Services.dart';
import 'dart:convert';
import 'package:flight_reservation/Screens/RegisterScreen.dart';
import 'package:flight_reservation/User.dart';

class LoginScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {

  void initState(){
    super.initState();
  }

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future<List> login() async{
    final response = await http.post(Services.LOGIN_ROOT, body: {
      "email" : email.text,
      "password" : pass.text,
    });

    var dataUser = json.decode(response.body);
    var currentUserId = dataUser[0]['id'];
    var currentUserFirstName = dataUser[0]['first_name'];
    var currentUserLastName = dataUser[0]['last_name'];

    if(dataUser[0]['level'] == 'admin'){
      Navigator.pushReplacementNamed(context, '/Homepage_Admin', arguments: {'currentUserId': currentUserId, 'currentUserFirstName' : currentUserFirstName,
        'currentUserLastName': currentUserLastName});
    }else if(dataUser[0]['level'] == 'member'){
      //Navigator.pushReplacementNamed(context, '/Homepage_Member');
      Navigator.pushReplacementNamed(context, '/Homepage_Member', arguments: {'currentUserId': currentUserId, 'currentUserFirstName' : currentUserFirstName,
      'currentUserLastName': currentUserLastName});
    }
    return dataUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),backgroundColor: new Color(0xFFf72a1b), centerTitle: true,),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: <Widget>[
              buildEmailField(),
              buildPasswordField(),
              buildSpace(),
              buildLoginButton(),
              buildSpace(),
              buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmailField() {
    return TextFormField(
      controller: email,
      style: TextStyle(color: Colors.black, fontSize: 23,),
      decoration: InputDecoration(
        labelText: "E-mail", labelStyle: TextStyle(color:new Color(0xFFf72a1b), fontSize: 14),
        //hintText: "enter username", hintStyle: TextStyle(fontSize: 20, color: Colors.white70),
        hoverColor: new Color(0xFFf72a1b), focusColor: new Color(0xFFf72a1b), fillColor: new Color(0xFFf72a1b),
        icon: Icon(Icons.person_outline, size: 40, color: new Color(0xFFf72a1b),),
      ),
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      controller: pass,
      obscureText: true,
      style: TextStyle(color: Colors.black, fontSize: 23),
      decoration: InputDecoration(
        labelText: "Password", labelStyle: TextStyle(color:new Color(0xFFf72a1b), fontSize: 14),
        //hintText: "enter password", hintStyle: TextStyle(fontSize: 20, color: Colors.white70),
        hoverColor: new Color(0xFFf72a1b), focusColor: new Color(0xFFf72a1b), fillColor: new Color(0xFFf72a1b),
        icon: Icon(Icons.vpn_key_outlined, size: 40,color: new Color(0xFFf72a1b),),
      ),
    );
  }

  Widget buildSpace(){
    return SizedBox(height: 20,);
  }

  Widget buildLoginButton(){
    return ButtonTheme(
      minWidth: double.infinity,
      height: 60,
      child: RaisedButton(
        child: Text("LOGIN", style: TextStyle(fontSize: 20, color: Colors.white),),
        color: new Color(0xFFf72a1b),
        onPressed: (){
          if(pass.text == "" || email.text == ""){
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Alanlar boş bırakılamaz.'),
                ));
          }else {
            login();
          }
        },
      ),
    );
  }

  Widget buildRegisterButton(){
    return ButtonTheme(
      minWidth: double.infinity,
      height: 60,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: new Color(0xFFf72a1b),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(16),
          side: BorderSide(width: 3.0, color: new Color(0xFFf72a1b)),
        ),
        child: Text("REGISTER", style: TextStyle(fontSize: 20, color: new Color(0xFFf72a1b)),),
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
        },
      ),
    );
  }
}