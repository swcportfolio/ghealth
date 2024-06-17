import 'package:ghealth_app/layers/entity/status_dto.dart';

class TotalPointDTO {
  final StatusDTO status;
  final String? data;

  TotalPointDTO({required this.status, required this.data});

  factory TotalPointDTO.fromJson(Map<String, dynamic> json) {
    return TotalPointDTO(
      status: StatusDTO.fromJson(json['status']),
      data: json['data'],
    );
  }
}