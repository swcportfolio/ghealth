class ReservationTimeData{
  final String reservationTime;

  ReservationTimeData({required this.reservationTime});

  factory ReservationTimeData.fromJson(Map<String, dynamic> json){
    return ReservationTimeData(
        reservationTime: json['reservationTime']);
  }

  static List<ReservationTimeData> jsonList(dynamic json) {
    var tagObjsJson = json as List;
    return tagObjsJson
        .map((json) => ReservationTimeData.fromJson(json))
        .toList();
  }
}