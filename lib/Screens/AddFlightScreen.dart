// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flight_reservation/main.dart';
import 'package:flight_reservation/Services.dart';
import 'package:flight_reservation/Screens/Homepage_Admin.dart';

class AddFlightScreen extends StatefulWidget{
  final String currentUserId;
  final String currentUserFirstName;
  final String currentUserLastName;

  AddFlightScreen({this.currentUserId, this.currentUserFirstName, this.currentUserLastName});

  @override
  State<StatefulWidget> createState() {
    return _AddFlightScreenState();
  }
}

class _AddFlightScreenState extends State<AddFlightScreen> {
  void initState(){
    super.initState();
  }

  TextEditingController fromController = new TextEditingController();
  TextEditingController toController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController departureController = new TextEditingController();
  TextEditingController arrivalController = new TextEditingController();
  TextEditingController ecopriceController = new TextEditingController();
  TextEditingController buspriceController = new TextEditingController();
  TextEditingController firstpriceController = new TextEditingController();

  String currentUserId;
  String currentUserFirstName;
  String currentUserLastName;

  @override
  Widget build(BuildContext context) {
    final routeData = ModalRoute.of(context).settings.arguments as Map<String, Object>;
    currentUserId = routeData['currentUserId'].toString();
    currentUserFirstName = routeData['currentUserFirstName'].toString();
    currentUserLastName = routeData['currentUserLastName'].toString();

    return Scaffold(
      appBar: AppBar(title: Text("Add Flight"),backgroundColor: new Color(0xFFf72a1b),),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: <Widget>[
              buildFromField(),
              buildToField(),
              buildDateField(),
              buildDepartureField(),
              buildArrivalField(),
              buildEcoField(),
              buildBusField(),
              buildFirstField(),
              buildSpace(),
              buildAddButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFromField() {
    return TextFormField(
        controller: fromController,
        style: TextStyle(color: Colors.black, fontSize: 23,),
    decoration: InputDecoration(
    hintText: "Nereden", hintStyle: TextStyle(fontSize: 20, color: new Color(0x69f72a1b)),
    hoverColor: new Color(0xFFf72a1b), focusColor: new Color(0xFFf72a1b), fillColor: new Color(0xFFf72a1b),
    ));
  }

  Widget buildDateField() {
    return TextFormField(
        controller: dateController,
        style: TextStyle(color: Colors.black, fontSize: 23,),
        decoration: InputDecoration(
          hintText: "YYYY-MM-DD", hintStyle: TextStyle(fontSize: 20, color: new Color(0x69f72a1b)),
          hoverColor: new Color(0xFFf72a1b), focusColor: new Color(0xFFf72a1b), fillColor: new Color(0xFFf72a1b),
        ));
  }

  Widget buildEcoField() {
    return TextFormField(
        controller: ecopriceController,
        style: TextStyle(color: Colors.black, fontSize: 23,),
        decoration: InputDecoration(
          hintText: "Economy fiyat", hintStyle: TextStyle(fontSize: 20, color: new Color(0x69f72a1b)),
          hoverColor: new Color(0xFFf72a1b), focusColor: new Color(0xFFf72a1b), fillColor: new Color(0xFFf72a1b),
        ));
  }

  Widget buildBusField() {
    return TextFormField(
        controller: buspriceController,
        style: TextStyle(color: Colors.black, fontSize: 23,),
        decoration: InputDecoration(
          hintText: "Business fiyat", hintStyle: TextStyle(fontSize: 20, color: new Color(0x69f72a1b)),
          hoverColor: new Color(0xFFf72a1b), focusColor: new Color(0xFFf72a1b), fillColor: new Color(0xFFf72a1b),
        ));
  }

  Widget buildFirstField() {
    return TextFormField(
        controller: firstpriceController,
        style: TextStyle(color: Colors.black, fontSize: 23,),
        decoration: InputDecoration(
          hintText: "First fiyat", hintStyle: TextStyle(fontSize: 20, color: new Color(0x69f72a1b)),
          hoverColor: new Color(0xFFf72a1b), focusColor: new Color(0xFFf72a1b), fillColor: new Color(0xFFf72a1b),
        ));
  }

  Widget buildDepartureField() {
    return TextFormField(
        controller: departureController,
        style: TextStyle(color: Colors.black, fontSize: 23,),
        decoration: InputDecoration(
          hintText: "YYYY-MM-DD HH:MM:SS", hintStyle: TextStyle(fontSize: 20, color: new Color(0x69f72a1b)),
          hoverColor: new Color(0xFFf72a1b), focusColor: new Color(0xFFf72a1b), fillColor: new Color(0xFFf72a1b),
        ));
  }

  Widget buildArrivalField() {
    return TextFormField(
        controller: arrivalController,
        style: TextStyle(color: Colors.black, fontSize: 23,),
        decoration: InputDecoration(
          hintText: "YYYY-MM-DD HH:MM:SS", hintStyle: TextStyle(fontSize: 20, color: new Color(0x69f72a1b)),
          hoverColor: new Color(0xFFf72a1b), focusColor: new Color(0xFFf72a1b), fillColor: new Color(0xFFf72a1b),
        ));
  }

  Widget buildToField() {
    return TextFormField(
        controller: toController,
        style: TextStyle(color: Colors.black, fontSize: 23,),
        decoration: InputDecoration(
          hintText: "Nereye", hintStyle: TextStyle(fontSize: 20, color: new Color(0x69f72a1b)),
          hoverColor: new Color(0xFFf72a1b), focusColor: new Color(0xFFf72a1b), fillColor: new Color(0xFFf72a1b),
        ));
  }

  Widget buildSpace(){
    return SizedBox(height: 20,);
  }

  Widget buildAddButton(){
    return ButtonTheme(
      minWidth: double.infinity,
      height: 60,
      child: RaisedButton(
        child: Text("EKLE", style: TextStyle(fontSize: 20, color: Colors.white),),
        color: new Color(0xFFf72a1b),
        onPressed: () {
          if(fromController.text != "" && toController.text != "" && dateController.text != "" &&
              departureController.text != "" && arrivalController.text != "" && ecopriceController.text != "" &&
              buspriceController.text != "" && firstpriceController.text != "") {
            Services.addFlight(fromController.text, toController.text, dateController.text, departureController.text,
            arrivalController.text, ecopriceController.text, buspriceController.text, firstpriceController.text,
            "100", "40", "10").then((result) {
              if ('success' == result) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Kayıt yapıldı.'),
                    ));
                Navigator.pushReplacementNamed(context, '/Homepage_Admin', arguments: {'currentUserId': currentUserId, 'currentUserFirstName' : currentUserFirstName,
                  'currentUserLastName': currentUserLastName});
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