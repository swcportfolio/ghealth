import 'status_dto.dart';

class SendAuthDTO {
  final StatusDTO status;
  final dynamic data; // null 반환됨

  SendAuthDTO({required this.status, this.data});

  factory SendAuthDTO.fromJson(Map<String, dynamic> json) {
    return SendAuthDTO(
      status: StatusDTO.fromJson(json['status']),
      data: json['data'],
    );
  }
}