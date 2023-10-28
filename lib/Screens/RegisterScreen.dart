import 'package:flutter/material.dart';
import 'package:flight_reservation/main.dart';
import 'package:flight_reservation/Services.dart';

class RegisterScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  void initState(){
    super.initState();
  }

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController firstnameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register"),backgroundColor: new Color(0xFFf72a1b),),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: <Widget>[
              buildEmailField(),
              buildPasswordField(),
              buildFirstNameField(),
              buildLastNameField(),
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
      controller: emailController,
      style: TextStyle(color: Colors.black, fontSize: 23,),
      decoration: InputDecoration(
        labelText: "E-mail", labelStyle: TextStyle(color:new Color(0xFFf72a1b), fontSize: 14),
        //hintText: "", hintStyle: TextStyle(fontSize: 20, color: new Color(0xFFf72a1b)),
        hoverColor: new Color(0xFFf72a1b), focusColor: new Color(0xFFf72a1b), fillColor: new Color(0xFFf72a1b),
        icon: Icon(Icons.person_outline, size: 40, color: new Color(0xFFf72a1b),),
      ),
    );
  }

  Widget buildFirstNameField() {
    return TextFormField(
      controller: firstnameController,
      style: TextStyle(color: Colors.black, fontSize: 23,),
      decoration: InputDecoration(
        labelText: "First Name", labelStyle: TextStyle(color:new Color(0xFFf72a1b), fontSize: 14),
        //hintText: "", hintStyle: TextStyle(fontSize: 20, color: new Color(0xFFf72a1b)),
        hoverColor: new Color(0xFFf72a1b), focusColor: new Color(0xFFf72a1b), fillColor: new Color(0xFFf72a1b),
        icon: Icon(Icons.account_box_outlined, size: 40, color: new Color(0xFFf72a1b),),
      ),
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      controller: lastnameController,
      style: TextStyle(color: Colors.black, fontSize: 23,),
      decoration: InputDecoration(
        labelText: "Last Name", labelStyle: TextStyle(color:new Color(0xFFf72a1b), fontSize: 14),
        //hintText: "", hintStyle: TextStyle(fontSize: 20, color: new Color(0xFFf72a1b)),
        hoverColor: new Color(0xFFf72a1b), focusColor: new Color(0xFFf72a1b), fillColor: new Color(0xFFf72a1b),
        icon: Icon(Icons.account_box_outlined, size: 40, color: new Color(0xFFf72a1b),),
      ),
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      style: TextStyle(color: Colors.black, fontSize: 23),
      decoration: InputDecoration(
        labelText: "Password", labelStyle: TextStyle(color:new Color(0xFFf72a1b), fontSize: 14),
        //hintText: "", hintStyle: TextStyle(fontSize: 20, color: new Color(0xFFf72a1b)),
        hoverColor: new Color(0xFFf72a1b), focusColor: new Color(0xFFf72a1b), fillColor: new Color(0xFFf72a1b),
        icon: Icon(Icons.vpn_key_outlined, size: 40,color: new Color(0xFFf72a1b),),
      ),
    );
  }

  Widget buildSpace(){
    return SizedBox(height: 20,);
  }

  Widget buildRegisterButton(){
    return ButtonTheme(
      minWidth: double.infinity,
      height: 60,
      child: RaisedButton(
        child: Text("REGISTER", style: TextStyle(fontSize: 20, color: Colors.white),),
        color: new Color(0xFFf72a1b),
        onPressed: () {
          if(emailController.text != "" && passwordController.text != "" && firstnameController.text != "" && lastnameController.text != "") {
            Services.addUser(emailController.text, passwordController.text,
                firstnameController.text, lastnameController.text, "member").then((result) {
              if ('success' == result) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Kayıt yapıldı.'),
                    ));
                Navigator.pushReplacementNamed(context, '/LoginScreen');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Bir hata oluştu.'),
                    ));
              }
            });
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Alanlar boş bırakılamaz.'),
                ));
          }
        },
      ),
    );
  }
}