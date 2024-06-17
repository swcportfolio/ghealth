import 'package:ghealth_app/layers/entity/status_dto.dart';

class CheckTokenDTO {
  final StatusDTO status;
  final dynamic data; // null 반환됨

  CheckTokenDTO({required this.status, this.data});

  factory CheckTokenDTO.fromJson(Map<String, dynamic> json) {
    return CheckTokenDTO(
      status: StatusDTO.fromJson(json['status']),
      data: json['data'],
    );
  }
}