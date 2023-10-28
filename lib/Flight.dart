// @dart=2.9
class Flight{
  String id;
  String from_location;
  String to_location;
  String flight_date;
  String departure_time;
  String arrival_time;
  String eco_price;
  String business_price;
  String first_price;
  String eco_count;
  String business_count;
  String first_count;

  Flight({this.id, this.from_location, this.to_location, this.flight_date, this.departure_time, this.arrival_time,
    this.eco_price, this.business_price, this.first_price, this.eco_count, this.business_count, this.first_count});

  factory Flight.fromJson(Map<String, dynamic> json){
    return Flight(
      id: json['id'] as String,
      from_location: json['from_location'] as String,
      to_location: json['to_location'] as String,
      flight_date: json['flight_date'] as String,
      departure_time: json['departure_time'] as String,
      arrival_time: json['arrival_time'] as String,
      eco_price: json['eco_price'] as String,
      business_price: json['business_price'] as String,
      first_price: json['first_price'] as String,
      eco_count: json['eco_count'] as String,
      business_count: json['business_count'] as String,
      first_count: json['first_count'] as String,
    );
  }
}