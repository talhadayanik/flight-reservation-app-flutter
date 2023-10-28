// @dart=2.9
import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flight_reservation/Flight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flight_reservation/Services.dart';
import 'package:flight_reservation/Pnr.dart';
import 'package:ticketview/ticketview.dart';

class Homepage_Member extends StatefulWidget {
  final String currentUserId;
  final String currentUserFirstName;
  final String currentUserLastName;

  Homepage_Member({this.currentUserId, this.currentUserFirstName, this.currentUserLastName});

  @override
  _Homepage_MemberState createState() => _Homepage_MemberState();
}

class _Homepage_MemberState extends State<Homepage_Member> {
  int pageIndex = 0;
  List<Flight> flightList;
  List<Flight> allFlights;
  List<Pnr> pnrList;
  Flight selectedFlight;
  Pnr selectedPnr;


  PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flightList = [];
    allFlights = [];
    pageController = PageController();
    _getFlights();
    _getPnrs(Homepage_Member().currentUserId);
  }

  _getFlights(){
    Services.getFlights().then((flights){
      setState((){
        flightList = flights;
        allFlights = flights;
      });
      print("Lenght ${flights.length}");
    });
  }

  _getPnrs(String user_id){
    Services.getPnrs(user_id).then((pnrs){
      setState((){
        pnrList = pnrs;
      });
      print("Lenght ${pnrs.length}");
    });
  }

  _getDesiredFlights(){
    Services.getDesiredFlights(fromLocationController.text, toLocationController.text, dateController.text).then((flights){
      setState((){
        flightList = flights;
      });
      print("Lenght ${flights.length}");
    });
  }

  Future<void> _showCancelDialog(String currentUserId) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Do you want to cancel?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                if(int.parse(selectedPnr.seat_no) > 50){
                  Services.updateFlight(selectedFlight.id, selectedFlight.from_location, selectedFlight.to_location,
                      selectedFlight.flight_date, selectedFlight.departure_time, selectedFlight.arrival_time,
                      selectedFlight.eco_price, selectedFlight.business_price, selectedFlight.first_price,
                      (int.parse(selectedFlight.eco_count) + 1).toString(), selectedFlight.business_count, selectedFlight.first_count);
                }else if(int.parse(selectedPnr.seat_no) > 10 && int.parse(selectedPnr.seat_no) <= 50){
                  Services.updateFlight(selectedFlight.id, selectedFlight.from_location, selectedFlight.to_location,
                      selectedFlight.flight_date, selectedFlight.departure_time, selectedFlight.arrival_time,
                      selectedFlight.eco_price, selectedFlight.business_price, selectedFlight.first_price,
                      selectedFlight.eco_count, (int.parse(selectedFlight.business_count) + 1).toString(), selectedFlight.first_count);
                }else if(int.parse(selectedPnr.seat_no) <= 10){
                  Services.updateFlight(selectedFlight.id, selectedFlight.from_location, selectedFlight.to_location,
                      selectedFlight.flight_date, selectedFlight.departure_time, selectedFlight.arrival_time,
                      selectedFlight.eco_price, selectedFlight.business_price, selectedFlight.first_price,
                      selectedFlight.eco_count, selectedFlight.business_count, (int.parse(selectedFlight.first_count) + 1).toString());
                }
                Services.deletePnr(selectedPnr.id);
                setState((){
                  _getPnrs(currentUserId);
                  Navigator.of(context).pop();
                });
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: (){
                setState((){
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  getTimediff(String date1, String date2){
    DateTime dt1 = DateTime.parse(date1);
    DateTime dt2 = DateTime.parse(date2);

    Duration diff = dt1.difference(dt2);
    return diff.inHours.toString() + ":" + (diff.inMinutes.toInt() % 60).toString() + " hours";
  }
  
  getFromLocation(String flightId){
    for(Flight flight in allFlights){
      if(flight.id == flightId){
        return flight.from_location;
      }
    }
  }

  getToLocation(String flightId){
    for(Flight flight in allFlights){
      if(flight.id == flightId){
        return flight.to_location;
      }
    }
  }

  getDepartureTime(String flightId){
    for(Flight flight in allFlights){
      if(flight.id == flightId){
        return flight.departure_time;
      }
    }
  }

  SingleChildScrollView _dataBody(String currentUserId, String currentUserFirstName, String currentUserLastName){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 20,
          columns: [
            DataColumn(
              label: Expanded(child: Text('ROUTE', textAlign: TextAlign.center, textScaleFactor: 1,),),
            ),
            DataColumn(
              label: Expanded(child: Text('DATE', textAlign: TextAlign.center, textScaleFactor: 1,),),
            ),
            DataColumn(
              label: Expanded(child: Text('DURATION', textAlign: TextAlign.center, textScaleFactor: 1,),),
            ),
            DataColumn(
              label: Expanded(child: Text('PRICE', textAlign: TextAlign.center, textScaleFactor: 1,),),
            ),
          ],
          rows: flightList.map((flight) => DataRow(
            //color: MaterialStateColor.resolveWith((states){return new Color(0xFFf72a1b);}),
            cells: [
              DataCell(
                  Text(flight.from_location.toUpperCase() + " --> " + flight.to_location.toUpperCase(), textScaleFactor: 1,),
                  onTap: (){
                    selectedFlight = flight;
                    Navigator.pushNamed(context, '/PurchaseScreen', arguments: {'currentFlight': flight,'currentUserId': currentUserId,'currentUserFirstName': currentUserFirstName, 'currentUserLastName': currentUserLastName}).then((value) => setState(() {}));
                  }
              ),
              DataCell(
                Text(flight.departure_time, textScaleFactor: 1,),
                onTap: (){
                  selectedFlight = flight;
                  Navigator.pushNamed(context, '/PurchaseScreen', arguments: {'currentFlight': flight,'currentUserId': currentUserId,'currentUserFirstName': currentUserFirstName, 'currentUserLastName': currentUserLastName}).then((value) => setState(() {}));
                }
              ),
              DataCell(
                Text(getTimediff(flight.arrival_time, flight.departure_time).toString(), textScaleFactor: 1,),
                  onTap: (){
                    selectedFlight = flight;
                    Navigator.pushNamed(context, '/PurchaseScreen', arguments: {'currentFlight': flight,'currentUserId': currentUserId,'currentUserFirstName': currentUserFirstName, 'currentUserLastName': currentUserLastName}).then((value) => setState(() {}));
                  }
              ),
              DataCell(
                Text(flight.eco_price, textScaleFactor: 1,),
                  onTap: (){
                    selectedFlight = flight;
                    Navigator.pushNamed(context, '/PurchaseScreen', arguments: {'currentFlight': flight,'currentUserId': currentUserId,'currentUserFirstName': currentUserFirstName, 'currentUserLastName': currentUserLastName}).then((value) => setState(() {}));
                  }
              ),
            ],
          ),).toList(),
        ),
      ),
    );
  }

  SingleChildScrollView _pnrDataBody(String currentUserId, String currentUserFirstName, String currentUserLastName){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 20,
          columns: [
            DataColumn(
              label: Expanded(child: Text('ROUTE', textAlign: TextAlign.center, textScaleFactor: 1,),),
            ),
            DataColumn(
              label: Expanded(child: Text('DATE', textAlign: TextAlign.center, textScaleFactor: 1,),),
            ),
            DataColumn(
              label: Expanded(child: Text('SEAT', textAlign: TextAlign.center, textScaleFactor: 1,),),
            ),
          ],
          rows: pnrList.map((pnr) => DataRow(
            //color: MaterialStateColor.resolveWith((states){return new Color(0xFFf72a1b);}),
            cells: [
              DataCell(
                  Text(getFromLocation(pnr.flight_id) + " --> " + getToLocation(pnr.flight_id)),
                  onTap: (){
                    setState((){
                      selectedPnr = pnr;
                    });
                    Services.getAFlight(selectedPnr.flight_id).then((flight){
                      setState((){
                        selectedFlight = flight[0];
                      });
                    });
                    _showCancelDialog(currentUserId);
                  }
              ),
              DataCell(
                  Text(getDepartureTime(pnr.flight_id), textScaleFactor: 1,),
                  onTap: (){
                    setState((){
                      selectedPnr = pnr;
                    });
                    Services.getAFlight(selectedPnr.flight_id).then((flight){
                      setState((){
                        selectedFlight = flight[0];
                      });
                    });
                    _showCancelDialog(currentUserId);
                  }
              ),
              DataCell(
                  Text(pnr.seat_no, textScaleFactor: 1,),
                  onTap: (){
                    setState((){
                      selectedPnr = pnr;
                    });
                    Services.getAFlight(selectedPnr.flight_id).then((flight){
                      setState((){
                        selectedFlight = flight[0];
                      });
                    });
                    _showCancelDialog(currentUserId);
                  }
              ),
            ],
          ),).toList(),
        ),
      ),
    );
  }

  TextEditingController fromLocationController = new TextEditingController();
  TextEditingController toLocationController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView(controller: pageController,
            onPageChanged: (newPage){
              setState((){
                this.pageIndex = newPage;
              });
            },
            children: [
              Container(
                child: Column(
                  children: [
                    TextFormField(
                      controller: fromLocationController,
                      style: TextStyle(color: Colors.black, fontSize: 23,),
                      decoration: InputDecoration(
                        hintText: "Nereden", hintStyle: TextStyle(fontSize: 20, color: new Color(0x69f72a1b)),
                        hoverColor: new Color(0xFFf72a1b), focusColor: new Color(0xFFf72a1b), fillColor: new Color(0xFFf72a1b),
                        ),
                    ),
                    TextFormField(
                      controller: toLocationController,
                      style: TextStyle(color: Colors.black, fontSize: 23,),
                      decoration: InputDecoration(
                        hintText: "Nereye", hintStyle: TextStyle(fontSize: 20, color: new Color(0x69f72a1b)),
                        hoverColor: new Color(0xFFf72a1b), focusColor: new Color(0xFFf72a1b), fillColor: new Color(0xFFf72a1b),
                      ),
                    ),
                    TextFormField(
                      controller: dateController,
                      style: TextStyle(color: Colors.black, fontSize: 23,),
                      decoration: InputDecoration(
                        hintText: "YYYY-MM-DD", hintStyle: TextStyle(fontSize: 20, color: new Color(0x69f72a1b)),
                        hoverColor: new Color(0xFFf72a1b), focusColor: new Color(0xFFf72a1b), fillColor: new Color(0xFFf72a1b),
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: new Color(0xFFf72a1b),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        side: BorderSide(width: 3.0, color: new Color(0xFFf72a1b)),
                      ),
                      child: Text("ARA", style: TextStyle(fontSize: 20, color: new Color(0xFFf72a1b)),),
                      onPressed: () async {
                        _getDesiredFlights();
                      },
                    ),

                    _dataBody(currentUserId, currentUserFirstName, currentUserLastName),
                  ],
                ),
              ),
              Container(
            child: Center(
              child: _pnrDataBody(currentUserId, currentUserFirstName, currentUserLastName),
            ),
          ),
              Container(
            child: Column(
              children: [
                Center(
                  child: Icon(Icons.person_outline, size: 300,),
                ),
                Center(
                  child: Text(currentUserFirstName.toUpperCase() + " " +currentUserLastName.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),textAlign: TextAlign.start,),
                ),
              ],
            ),
          ),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (idx) {
          setState(() {
            pageIndex = idx;
            _getPnrs(currentUserId);
            _pnrDataBody(currentUserId, currentUserFirstName, currentUserLastName);
          });
          pageController.jumpToPage(idx);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: new Color(0xFFf72a1b),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_num_outlined), label: "My Tickets"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outlined), label: "Profile"),
        ],
      ),
    );
  }
}