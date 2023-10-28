// @dart=2.9
class Pnr{
  String id;
  String user_id;
  String flight_id;
  String seat_no;

  Pnr({this.id, this.user_id, this.flight_id, this.seat_no});

  factory Pnr.fromJson(Map<String, dynamic> json){
    return Pnr(
      id: json['id'] as String,
      user_id: json['user_id'] as String,
      flight_id: json['flight_id'] as String,
      seat_no: json['seat_no'] as String,
    );
  }
}