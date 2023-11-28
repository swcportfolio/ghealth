
class ReservationData {
  late String? reservationIdx; //예약 번호
  late String? reservationDate; //예약 날짜
  late String? reservationTime; //예약 시간
  late String? reservationStatus; //예약 상태

  ReservationData(
      {this.reservationIdx,
       this.reservationDate,
       this.reservationTime,
       this.reservationStatus});

  factory ReservationData.fromJson(Map<String, dynamic>? json){
    return ReservationData(
        reservationIdx: json?['reservationIdx'] ?? '',
        reservationDate: json?['reservationDate'] ?? '',
        reservationTime: json?['reservationTime'] ?? '',
        reservationStatus: json?['reservationStatus']?? '',
    );
  }

  static List<ReservationData> jsonList(dynamic json) {
    var tagObjsJson = json as List;
    return tagObjsJson
        .map((json) => ReservationData.fromJson(json))
        .toList();
  }
}