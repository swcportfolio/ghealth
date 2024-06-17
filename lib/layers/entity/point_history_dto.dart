import 'package:ghealth_app/layers/entity/status_dto.dart';

import '../../data/models/point_hisstory.dart';

class PointHistoryDTO {
  final StatusDTO status;
  final List<PointHistoryDataDTO>? data;

  PointHistoryDTO({required this.status, required this.data});

  factory PointHistoryDTO.fromJson(Map<String, dynamic> json) {
    return PointHistoryDTO(
      status: StatusDTO.fromJson(json['status']),
      data: json['data'] == null ? null : PointHistoryDataDTO.jsonToList(json['data']),
    );
  }
}


class PointHistoryDataDTO {
  late String userID;
  late String serviceType;
  late String pointType;
  late String point;
  late String pointDesc;
  late String createDT;

  PointHistoryDataDTO({
    required this.userID,
    required this.serviceType,
    required this.pointType,
    required this.point,
    required this.pointDesc,
    required this.createDT,
  });

  factory PointHistoryDataDTO.fromJson(Map<String, dynamic> json) {
    return PointHistoryDataDTO(
      userID: json['userID'],
      serviceType: json['serviceType']?? '',
      pointType: json['pointType'],
      point: json['point'],
      pointDesc: json['pointDesc'],
      createDT: json['createDT'],
    );
  }

  static List<PointHistoryDataDTO> jsonToList(dynamic json) {
    var tagObjsJson = json as List;
    return tagObjsJson.map((json) =>
        PointHistoryDataDTO.fromJson(json)).toList();
  }
}