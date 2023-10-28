// @dart=2.9
import 'package:badges/badges.dart';
import 'package:flight_reservation/Flight.dart';
import 'package:flight_reservation/Screens/AddFlightScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flight_reservation/Services.dart';
import 'package:flight_reservation/Pnr.dart';
import 'package:flight_reservation/User.dart';
import 'package:ticketview/ticketview.dart';

class Homepage_Admin extends StatefulWidget {
  final String currentUserId;
  final String currentUserFirstName;
  final String currentUserLastName;

  Homepage_Admin({this.currentUserId, this.currentUserFirstName, this.currentUserLastName});

  @override
  _Homepage_AdminState createState() => _Homepage_AdminState();
}

class _Homepage_AdminState extends State<Homepage_Admin> {
  int pageIndex = 0;
  List<Flight> flightList;
  List<User> userList;
  Flight selectedFlight;
  User selectedUser;

  PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flightList = [];
    userList = [];
    pageController = PageController();
    _getFlights();
    _getUsers();
  }

  _getFlights(){
    Services.getFlights().then((flights){
      setState((){
        flightList = flights;
      });
      print("Lenght ${flights.length}");
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

  _getUsers(){
    Services.getUsers().then((users){
      setState((){
        userList = users;
      });
      print("Lenght ${users.length}");
    });
  }

  Future<void> _showUpdateDialogUser(User usr) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select: '),
          actions: <Widget>[
            TextButton(
              child: const Text('Delete User'),
              onPressed: () {
                Services.deleteUser(usr.id);
                setState((){
                  _getUsers();
                  Navigator.of(context).pop();
                });
              },
            ),/*
            TextButton(
              child: const Text("Admin"),
              onPressed: (){
                  Services.updateUser(usr.id, usr.email, usr.password,
                      usr.first_name, usr.last_name, 'admin');
                setState((){
                  _getUsers();
                  Navigator.of(context).pop();
                });
              },
            ),
            TextButton(
              child: const Text("Member"),
              onPressed: (){
                Services.updateUser(usr.id, usr.email, usr.password, usr.first_name,
                    usr.last_name, 'member');
                setState((){
                  _getUsers();
                  Navigator.of(context).pop();
                });
              },
            ),
            */
          ],
        );
      },
    );
  }

  Future<void> _showUpdateDialogFlight(Flight flight) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select: '),
          actions: <Widget>[
            TextButton(
              child: const Text('Delete User'),
              onPressed: () {
                Services.deleteFlight(flight.id);
                setState((){
                  _getFlights();
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
                    Navigator.pushNamed(context, '/UpdateFlightScreen', arguments: {'currentUserId': currentUserId,'currentUserFirstName': currentUserFirstName, 'currentUserLastName': currentUserLastName,
                      'selectedFlightId': selectedFlight.id,'from_location': selectedFlight.from_location, 'to_location': selectedFlight.to_location, 'flight_date': selectedFlight.flight_date,
                      'departure_time': selectedFlight.departure_time, 'arrival_time': selectedFlight.arrival_time, 'eco_price': selectedFlight.eco_price,
                      'business_price': selectedFlight.business_price, 'first_price': selectedFlight.first_price}).then((value) => setState(() {}));
                  }
              ),
              DataCell(
                  Text(flight.departure_time, textScaleFactor: 1,),
                  onTap: (){
                    selectedFlight = flight;
                    Navigator.pushNamed(context, '/UpdateFlightScreen', arguments: {'currentUserId': currentUserId,'currentUserFirstName': currentUserFirstName, 'currentUserLastName': currentUserLastName,
                      'selectedFlightId': selectedFlight.id,'from_location': selectedFlight.from_location, 'to_location': selectedFlight.to_location, 'flight_date': selectedFlight.flight_date,
                      'departure_time': selectedFlight.departure_time, 'arrival_time': selectedFlight.arrival_time, 'eco_price': selectedFlight.eco_price,
                      'business_price': selectedFlight.business_price, 'first_price': selectedFlight.first_price}).then((value) => setState(() {}));
                  }
              ),
              DataCell(
                  Text(getTimediff(flight.arrival_time, flight.departure_time).toString(), textScaleFactor: 1,),
                  onTap: (){
                    selectedFlight = flight;
                    Navigator.pushNamed(context, '/UpdateFlightScreen', arguments: {'currentUserId': currentUserId,'currentUserFirstName': currentUserFirstName, 'currentUserLastName': currentUserLastName,
                      'selectedFlightId': selectedFlight.id,'from_location': selectedFlight.from_location, 'to_location': selectedFlight.to_location, 'flight_date': selectedFlight.flight_date,
                      'departure_time': selectedFlight.departure_time, 'arrival_time': selectedFlight.arrival_time, 'eco_price': selectedFlight.eco_price,
                      'business_price': selectedFlight.business_price, 'first_price': selectedFlight.first_price}).then((value) => setState(() {}));
                  }
              ),
              DataCell(
                  Text(flight.eco_price, textScaleFactor: 1,),
                  onTap: (){
                    selectedFlight = flight;
                    Navigator.pushNamed(context, '/UpdateFlightScreen', arguments: {'currentUserId': currentUserId,'currentUserFirstName': currentUserFirstName, 'currentUserLastName': currentUserLastName,
                      'selectedFlightId': selectedFlight.id,'from_location': selectedFlight.from_location, 'to_location': selectedFlight.to_location, 'flight_date': selectedFlight.flight_date,
                      'departure_time': selectedFlight.departure_time, 'arrival_time': selectedFlight.arrival_time, 'eco_price': selectedFlight.eco_price,
                      'business_price': selectedFlight.business_price, 'first_price': selectedFlight.first_price}).then((value) => setState(() {}));
                  }
              ),
            ],
          ),).toList(),
        ),
      ),
    );
  }

  SingleChildScrollView _userDataBody(String currentUserId, String currentUserFirstName, String currentUserLastName){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 20,
          columns: [
            DataColumn(
              label: Expanded(child: Text('ID', textAlign: TextAlign.center, textScaleFactor: 1,),),
            ),
            DataColumn(
              label: Expanded(child: Text('NAME', textAlign: TextAlign.center, textScaleFactor: 1,),),
            ),
            DataColumn(
              label: Expanded(child: Text('LEVEL', textAlign: TextAlign.center, textScaleFactor: 1,),),
            ),
          ],
          rows: userList.map((user) => DataRow(
            //color: MaterialStateColor.resolveWith((states){return new Color(0xFFf72a1b);}),
            cells: [
              DataCell(
                  Text(user.id, textScaleFactor: 1,),
                  onTap: (){
                    setState((){
                      selectedUser = user;
                    });
                    _showUpdateDialogUser(selectedUser);
                  }
              ),
              DataCell(
                  Text(user.first_name.toUpperCase() + " " + user.last_name.toUpperCase(), textScaleFactor: 1,),
                  onTap: (){
                    setState((){
                      selectedUser = user;
                    });
                    _showUpdateDialogUser(selectedUser);
                  }
              ),
              DataCell(
                  Text(user.level, textScaleFactor: 1,),
                  onTap: (){
                    setState((){
                      selectedUser = user;
                    });
                    _showUpdateDialogUser(selectedUser);
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

  @override
  Widget build(BuildContext context) {
    final routeData = ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final String currentUserId = routeData['currentUserId'].toString();
    final String currentUserFirstName = routeData['currentUserFirstName'].toString();
    final String currentUserLastName = routeData['currentUserLastName'].toString();

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
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: new Color(0xFFf72a1b),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        side: BorderSide(width: 3.0, color: new Color(0xFFf72a1b)),
                      ),
                      child: Text("EKLE", style: TextStyle(fontSize: 20, color: new Color(0xFFf72a1b)),),
                      onPressed: () async {
                        Navigator.pushNamed(context, '/AddFlightScreen', arguments: {'currentUserId': currentUserId, 'currentUserFirstName' : currentUserFirstName,
                          'currentUserLastName': currentUserLastName});
                      },
                    ),

                    _dataBody(currentUserId, currentUserFirstName, currentUserLastName),
                  ],
                ),
              ),
              Container(
                child: Center(
                  child: _userDataBody(currentUserId, currentUserFirstName, currentUserLastName),
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
            _getUsers();
            _userDataBody(currentUserId, currentUserFirstName, currentUserLastName);
          });
          pageController.jumpToPage(idx);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: new Color(0xFFf72a1b),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Flights"),
          BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: "Users"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outlined), label: "Profile"),
        ],
      ),
    );
  }
}