// @dart=2.9
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flight_reservation/Flight.dart';
import 'package:flight_reservation/User.dart';
import 'package:flight_reservation/Services.dart';
import 'package:ticketview/ticketview.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:flight_reservation/Screens/Homepage_Member.dart';
import 'package:flight_reservation/Services.dart';

class PurchaseScreen extends StatefulWidget{
  final String currentUserId;
  final String currentUserFirstName;
  final String currentUserLastName;
  final Flight currentFlight;

  PurchaseScreen({this.currentUserId, this.currentFlight, this.currentUserFirstName, this.currentUserLastName});

  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  List<Flight> flightList;
  int pageIndex = 0;

  PageController pageController;


  @override
  void initState() {
    super.initState();
    flightList = [];
    pageController = PageController();
    //_refreshCF(currentFlight);
  }

  /*
  _refreshCF(String CFid){
    Services.getAFlight(CFid).then((flight){
      setState((){
        flightList.remove(currentFlight);
        currentFlight = flight[0];
        flightList.add(currentFlight);
      });
    });
  }

   */



  @override
  Widget build(BuildContext context) {
    final routeData = ModalRoute.of(context).settings.arguments as Map<String, Object>;
    String currentUserId = routeData['currentUserId'].toString();
    Flight currentFlight = routeData['currentFlight'];
    String currentUserFirstName = routeData['currentUserFirstName'];
    String currentUserLastName = routeData['currentUserLastName'];
    flightList.add(currentFlight);

    return Scaffold(
      appBar: AppBar(title: Text('Purchase'),backgroundColor: new Color(0xFFf72a1b),),
      backgroundColor: Colors.white,
      body: PageView(controller: pageController, onPageChanged: (newPage){setState(){this.pageIndex = newPage;}},
      children: [
        Center(
          child: FlutterTicketWidget(
            width: 350,
            height: 500,
            isCornerRounded: true,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  <Widget>[
                      Container(
                        width: 120,
                        height: 25,

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 1, color: Colors.green)
                        ),
                        child: Center(
                          child: Text(
                            'Economy Class',
                            style: TextStyle(
                                color: Colors.green
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            currentFlight.from_location,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Icon(
                              Icons.flight_takeoff,
                              color: Colors.pink,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              currentFlight.to_location,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Flight Ticket',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      children: <Widget>[
                        ticketDetailsWidget('Passengers', currentUserFirstName.toUpperCase() + " " + currentUserLastName.toUpperCase(),
                            'Date', currentFlight.flight_date),
                        Padding(
                          padding: const EdgeInsets.only(top: 12, right: 40),
                          child: ticketDetailsWidget('Class', 'Economy', 'Seat', (int.parse(currentFlight.eco_count) + 50).toString()),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
                    child: Container(
                      width: 250,
                      height: 60,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 75, right: 75),
                    child: Text(
                      currentFlight.eco_price + "TL",
                      style: TextStyle(
                          color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 75,right: 75),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: new Color(0xFFf72a1b),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        side: BorderSide(width: 3.0, color: new Color(0xFFf72a1b)),
                      ),
                      child: Text("SATIN AL", style: TextStyle(fontSize: 20, color: new Color(0xFFf72a1b)),),
                      onPressed: () async {
                        if(int.parse(currentFlight.eco_count) > 50){
                          Services.addPnr(currentUserId, currentFlight.id, (int.parse(currentFlight.eco_count) + 50).toString());
                          Services.updateFlight(currentFlight.id, currentFlight.from_location, currentFlight.to_location,
                              currentFlight.flight_date, currentFlight.departure_time, currentFlight.arrival_time,
                              currentFlight.eco_price, currentFlight.business_price, currentFlight.first_price,
                              (int.parse(currentFlight.eco_count) - 1).toString(), currentFlight.business_count,
                              currentFlight.first_count).then((result){
                            if ('success' == result) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Kayıt yapıldı.'),
                                  ));
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
                                content: Text('Bilet kalmadı.'),
                              ));
                        }
                        Services.getAFlight(currentFlight.id).then((flights){
                          setState((){currentFlight = flights[0];});
                        });
                        Navigator.pushNamed( context, '/Homepage_Member', arguments: {'currentUserId': currentUserId, 'currentUserFirstName' : currentUserFirstName,
                          'currentUserLastName': currentUserLastName}).then((value) => setState(() {}));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: FlutterTicketWidget(
            width: 350,
            height: 500,
            isCornerRounded: true,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  <Widget>[
                      Container(
                        width: 120,
                        height: 25,

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 1, color: Colors.blue)
                        ),
                        child: Center(
                          child: Text(
                            'Business Class',
                            style: TextStyle(
                                color: Colors.blue
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            currentFlight.from_location,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Icon(
                              Icons.flight_takeoff,
                              color: Colors.pink,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              currentFlight.to_location,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Flight Ticket',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      children: <Widget>[
                        ticketDetailsWidget('Passengers', currentUserFirstName.toUpperCase() + " " + currentUserLastName.toUpperCase(),
                            'Date', currentFlight.flight_date),
                        Padding(
                          padding: const EdgeInsets.only(top: 12, right: 40),
                          child: ticketDetailsWidget('Class', 'Business', 'Seat', (int.parse(currentFlight.business_count) + 10).toString()),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
                    child: Container(
                      width: 250,
                      height: 60,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 75, right: 75),
                    child: Text(
                      currentFlight.business_price + "TL",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 75,right: 75),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: new Color(0xFFf72a1b),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        side: BorderSide(width: 3.0, color: new Color(0xFFf72a1b)),
                      ),
                      child: Text("SATIN AL", style: TextStyle(fontSize: 20, color: new Color(0xFFf72a1b)),),
                      onPressed: () async {
                        if(int.parse(currentFlight.business_count) > 10){
                          Services.addPnr(currentUserId, currentFlight.id, (int.parse(currentFlight.business_count) + 10).toString());
                          Services.updateFlight(currentFlight.id, currentFlight.from_location, currentFlight.to_location,
                              currentFlight.flight_date, currentFlight.departure_time, currentFlight.arrival_time,
                              currentFlight.eco_price, currentFlight.business_price, currentFlight.first_price,
                              currentFlight.eco_count, (int.parse(currentFlight.business_count) - 1).toString(),
                              currentFlight.first_count).then((result){
                            if ('success' == result) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Kayıt yapıldı.'),
                                  ));
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
                                content: Text('Bilet kalmadı.'),
                              ));
                        }
                        Services.getAFlight(currentFlight.id).then((flights){
                          setState((){currentFlight = flights[0];});
                        });
                        Navigator.pushNamed( context, '/Homepage_Member', arguments: {'currentUserId': currentUserId, 'currentUserFirstName' : currentUserFirstName,
                          'currentUserLastName': currentUserLastName}).then((value) => setState(() {}));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: FlutterTicketWidget(
            width: 350,
            height: 500,
            isCornerRounded: true,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  <Widget>[
                      Container(
                        width: 120,
                        height: 25,

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 1, color: new Color(0xFFf72a1b))
                        ),
                        child: Center(
                          child: Text(
                            'First Class',
                            style: TextStyle(
                                color: new Color(0xFFf72a1b)
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            currentFlight.from_location,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Icon(
                              Icons.flight_takeoff,
                              color: Colors.pink,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              currentFlight.to_location,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Flight Ticket',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      children: <Widget>[
                        ticketDetailsWidget('Passengers', currentUserFirstName.toUpperCase() + " " + currentUserLastName.toUpperCase(),
                            'Date', currentFlight.flight_date),
                        Padding(
                          padding: const EdgeInsets.only(top: 12, right: 40),
                          child: ticketDetailsWidget('Class', 'First', 'Seat', (int.parse(currentFlight.first_count)).toString()),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
                    child: Container(
                      width: 250,
                      height: 60,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 75, right: 75),
                    child: Text(
                      currentFlight.first_price + "TL",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 75,right: 75),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: new Color(0xFFf72a1b),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        side: BorderSide(width: 3.0, color: new Color(0xFFf72a1b)),
                      ),
                      child: Text("SATIN AL", style: TextStyle(fontSize: 20, color: new Color(0xFFf72a1b)),),
                      onPressed: () async {
                        if(int.parse(currentFlight.first_count) > 0){
                          Services.addPnr(currentUserId, currentFlight.id, (currentFlight.first_count).toString());
                          Services.updateFlight(currentFlight.id, currentFlight.from_location, currentFlight.to_location,
                              currentFlight.flight_date, currentFlight.departure_time, currentFlight.arrival_time,
                              currentFlight.eco_price, currentFlight.business_price, currentFlight.first_price,
                              currentFlight.eco_count, currentFlight.business_count,
                              (int.parse(currentFlight.first_count) - 1).toString()).then((result){
                            if ('success' == result) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Kayıt yapıldı.'),
                                  ));
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
                                content: Text('Bilet kalmadı.'),
                              ));
                        }
                        Services.getAFlight(currentFlight.id).then((flights){
                          setState((){currentFlight = flights[0];});
                        });
                        Navigator.pushNamed( context, '/Homepage_Member', arguments: {'currentUserId': currentUserId, 'currentUserFirstName' : currentUserFirstName,
                          'currentUserLastName': currentUserLastName}).then((value) => setState(() {}));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
      ),
    );
  }
}

Widget ticketDetailsWidget(String firstTitle, String firstDesc, String secondTitle, String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstTitle,
              style: TextStyle(
                  color: Colors.grey
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                firstDesc,
                style: TextStyle(
                    color: Colors.black
                ),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              secondTitle,
              style: TextStyle(
                  color: Colors.grey
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                secondDesc,
                style: TextStyle(
                    color: Colors.black
                ),
              ),
            )
          ],
        ),
      )
    ],
  );
}