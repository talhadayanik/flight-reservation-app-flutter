// @dart=2.9
import 'dart:convert';
import 'dart:ffi';
import 'Flight.dart';
import 'package:http/http.dart' as http;
import 'User.dart';
import 'Pnr.dart';

class Services {
  static const LOGIN_ROOT = 'http://192.168.1.184:80/Users/login.php';
  static const USER_ACTIONS_ROOT = 'http://192.168.1.184:80/Users/user_actions.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_USERS_ACTION = 'GET_ALL_USERS';
  static const _ADD_USER_ACTION = 'ADD_USER';
  static const _UPDATE_USER_ACTION = 'UPDATE_USER';
  static const _DELETE_USER_ACTION = 'DELETE_USER';
  static const _GET_ALL_FLIGHTS_ACTION = 'GET_ALL_FLIGHTS';
  static const _ADD_FLIGHT_ACTION = 'ADD_FLIGHT';
  static const _UPDATE_FLIGHT_ACTION = 'UPDATE_FLIGHT';
  static const _GET_A_FLIGHT_ACTION = 'GET_A_FLIGHT';
  static const _GET_DESIRED_FLIGHTS_ACTION = 'GET_DESIRED_FLIGHTS';
  static const _ADD_PNR_ACTION = 'ADD_PNR';
  static const _GET_PNRS_ACTION = 'GET_PNRS';
  static const _DELETE_PNR_ACTION = 'DELETE_PNR';
  static const _DELETE_FLIGHT_ACTION = 'DELETE_FLIGHT';

  static Future<String> createTable() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(USER_ACTIONS_ROOT, body: map);
      print('Create Table Response: ${response.body}');
      if(200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    }catch(e){
      return "error exception";
    }
  }

  static Future<List<User>> getUsers() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_USERS_ACTION;
      final response = await http.post(USER_ACTIONS_ROOT, body: map);
      print('getUsers Response: ${response.body}');
      if(200 == response.statusCode){
        List<User> list = userParseResponse(response.body);
        return list;
      }else{
        return List<User>();
      }
    }catch(e){
      return List<User>();
    }
  }

  static List<User> userParseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static Future<List<Pnr>> getPnrs(String user_id) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _GET_PNRS_ACTION;
      map['user_id'] = user_id;
      final response = await http.post(USER_ACTIONS_ROOT, body: map);
      print('getPnrs Response: ${response.body}');
      if(200 == response.statusCode){
        List<Pnr> list = pnrParsedResponse(response.body);
        return list;
      }else{
        return List<Pnr>();
      }
    }catch(e){
      return List<Pnr>();
    }
  }

  static Future<String> addPnr(String userId, String flightId, String seatNo) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _ADD_PNR_ACTION;
      map['user_id'] = userId;
      map['flight_id'] = flightId;
      map['seat_no'] = seatNo;
      final response = await http.post(USER_ACTIONS_ROOT, body: map);
      print('addPnr Response: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    }catch(e){
      return "error";
    }
  }

  static Future<String> addUser(String email, String password, String firstName, String lastName, String level) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _ADD_USER_ACTION;
      map['email'] = email;
      map['password'] = password;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      map['level'] = level;
      final response = await http.post(USER_ACTIONS_ROOT, body: map);
      print('addUser Response: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    }catch(e){
      return "error";
    }
  }

  static Future<String> updateUser(String user_id, String email, String password, String first_name, String last_name, String level) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_USER_ACTION;
      map['user_id'] = user_id;
      map['email'] = email;
      map['password'] = password;
      map['first_name'] = first_name;
      map['last_name'] = last_name;
      map['level'] = level;
      final response = await http.post(USER_ACTIONS_ROOT, body: map);
      print('updateUser Response: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    }catch(e){
      return "error";
    }
  }

  static Future<String> deleteUser(String userId) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_USER_ACTION;
      map['user_id'] = userId;
      final response = await http.post(USER_ACTIONS_ROOT, body: map);
      print('deleteUser Response: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    }catch(e){
      return "error";
    }
  }

  static Future<String> deletePnr(String pnr_id) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_PNR_ACTION;
      map['pnr_id'] = pnr_id;
      final response = await http.post(USER_ACTIONS_ROOT, body: map);
      print('deletePnr Response: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    }catch(e){
      return "error";
    }
  }

  static List<Flight> flightParseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Flight>((json) => Flight.fromJson(json)).toList();
  }

  static List<Pnr> pnrParsedResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Pnr>((json) => Pnr.fromJson(json)).toList();
  }

  static Future<List<Flight>> getAFlight(String flight_id) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _GET_A_FLIGHT_ACTION;
      map['flight_id'] = flight_id;
      final response = await http.post(USER_ACTIONS_ROOT, body: map);
      print('getFlights Response: ${response.body}');
      if(200 == response.statusCode){
        List<Flight> list = flightParseResponse(response.body);
        return list;
      }else{
        return List<Flight>();
      }
    }catch(e){
      return List<Flight>();
    }
  }

  static Future<Flight> getAFlightasFlight(String flight_id) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _GET_A_FLIGHT_ACTION;
      map['flight_id'] = flight_id;
      final response = await http.post(USER_ACTIONS_ROOT, body: map);
      print('getAFlightasFlight Response: ${response.body}');
      if(200 == response.statusCode){
        List<Flight> list = flightParseResponse(response.body);
        Flight flight = list[0];
        return flight;
      }else{
        return Flight();
      }
    }catch(e){
      return Flight();
    }
  }


  static Future<List<Flight>> getFlights() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_FLIGHTS_ACTION;
      final response = await http.post(USER_ACTIONS_ROOT, body: map);
      print('getFlights Response: ${response.body}');
      if(200 == response.statusCode){
        List<Flight> list = flightParseResponse(response.body);
        return list;
      }else{
        return List<Flight>();
      }
    }catch(e){
      return List<Flight>();
    }
  }

  static Future<List<Flight>> getDesiredFlights(String fromLocation, String toLocation, String date) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _GET_DESIRED_FLIGHTS_ACTION;
      map['from_location'] = fromLocation;
      map['to_location'] = toLocation;
      map['flight_date'] = date;
      final response = await http.post(USER_ACTIONS_ROOT, body: map);
      print('getDesiredFlights Response: ${response.body}');
      if(200 == response.statusCode){
        List<Flight> list = flightParseResponse(response.body);
        return list;
      }else{
        return List<Flight>();
      }
    }catch(e){
      return List<Flight>();
    }
  }

  static Future<String> updateFlight(String id, String from_location, String to_location,
      String flight_date, String departure_time, String arrival_time, String eco_price, String business_price,
      String first_price, String eco_count, String business_count, String first_count) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_FLIGHT_ACTION;
      map['flight_id'] = id;
      map['from_location'] = from_location;
      map['to_location'] = to_location;
      map['flight_date'] = flight_date;
      map['departure_time'] = departure_time;
      map['arrival_time'] = arrival_time;
      map['eco_price'] = eco_price;
      map['business_price'] = business_price;
      map['first_price'] = first_price;
      map['eco_count'] = eco_count;
      map['business_count'] = business_count;
      map['first_count'] = first_count;
      final response = await http.post(USER_ACTIONS_ROOT, body: map);
      print('updateFlight Response: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    }catch(e){
      return "error";
    }
  }

  static Future<String> addFlight(String from_location, String to_location, String flight_date, String departure_time,
      String arrival_time, String eco_price, String business_price, String first_price, String eco_count,
      String business_count, String first_count) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _ADD_FLIGHT_ACTION;
      map['from_location'] = from_location;
      map['to_location'] = to_location;
      map['flight_date'] = flight_date;
      map['departure_time'] = departure_time;
      map['arrival_time'] = arrival_time;
      map['eco_price'] = eco_price;
      map['business_price'] = business_price;
      map['first_price'] = first_price;
      map['eco_count'] = eco_count;
      map['business_count'] = business_count;
      map['first_count'] = first_count;
      final response = await http.post(USER_ACTIONS_ROOT, body: map);
      print('addUser Response: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    }catch(e){
      return "error";
    }
  }

  static Future<String> deleteFlight(String flightId) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_FLIGHT_ACTION;
      map['flight_id'] = flightId;
      final response = await http.post(USER_ACTIONS_ROOT, body: map);
      print('deleteFlight Response: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    }catch(e){
      return "error";
    }
  }

}

