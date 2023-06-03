// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flight_reservation/main.dart';
import 'package:flight_reservation/Services.dart';
import 'package:flight_reservation/Screens/Homepage_Admin.dart';
import 'package:flutter/services.dart';

class UpdateFlightScreen extends StatefulWidget{
  final String currentUserId;
  final String currentUserFirstName;
  final String currentUserLastName;
  final String selectedFlightId;
  final String from_location;
  final String to_location;
  final String flight_date;
  final String departure_time;
  final String arrival_time;
  final String eco_price;
  final String business_price;
  final String first_price;

  UpdateFlightScreen({this.selectedFlightId, this.currentUserId, this.currentUserFirstName, this.currentUserLastName, this.from_location,
    this.to_location, this.flight_date, this.departure_time, this.arrival_time, this.eco_price, this.business_price,
    this.first_price});

  @override
  State<StatefulWidget> createState() {
    return _UpdateFlightScreenState();
  }
}

class _UpdateFlightScreenState extends State<UpdateFlightScreen> {

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
  String selectedFlightId;
  String from_location;
  String to_location;
  String flight_date;
  String departure_time;
  String arrival_time;
  String eco_price;
  String business_price;
  String first_price;

  @override
  Widget build(BuildContext context) {
    final routeData = ModalRoute.of(context).settings.arguments as Map<String, Object>;
    currentUserId = routeData['currentUserId'].toString();
    currentUserFirstName = routeData['currentUserFirstName'].toString();
    currentUserLastName = routeData['currentUserLastName'].toString();
    selectedFlightId = routeData['selectedFlightId'].toString();
    from_location = routeData['from_location'].toString();
    to_location = routeData['to_location'].toString();
    flight_date = routeData['flight_date'].toString();
    departure_time = routeData['departure_time'].toString();
    arrival_time = routeData['arrival_time'].toString();
    eco_price = routeData['eco_price'].toString();
    business_price = routeData['business_price'].toString();
    first_price = routeData['first_price'].toString();

    fromController.text = from_location;
    toController.text = to_location;
    dateController.text = flight_date;
    departureController.text = departure_time;
    arrivalController.text = arrival_time;
    ecopriceController.text = eco_price;
    buspriceController.text = business_price;
    firstpriceController.text = first_price;

    return Scaffold(
      appBar: AppBar(title: Text("Update Flight"),backgroundColor: new Color(0xFFf72a1b),),
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
              buildUpdateButton(),
              buildSpace(),
              buildDeleteButton(),
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

  Widget buildUpdateButton(){
    return ButtonTheme(
      minWidth: double.infinity,
      height: 60,
      child: RaisedButton(
        child: Text("UPDATE", style: TextStyle(fontSize: 20, color: Colors.white),),
        color: new Color(0xFFf72a1b),
        onPressed: () {
          if(fromController.text != "" && toController.text != "" && dateController.text != "" &&
              departureController.text != "" && arrivalController.text != "" && ecopriceController.text != "" &&
              buspriceController.text != "" && firstpriceController.text != "") {
            Services.updateFlight(selectedFlightId, fromController.text, toController.text, dateController.text, departureController.text,
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

  Widget buildDeleteButton(){
    return ButtonTheme(
      minWidth: double.infinity,
      height: 60,
      child: RaisedButton(
        child: Text("DELETE", style: TextStyle(fontSize: 20, color: Colors.white),),
        color: new Color(0xFFf72a1b),
        onPressed: () {
            Services.deleteFlight(selectedFlightId).then((result) {
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
        },
      ),
    );
  }
}