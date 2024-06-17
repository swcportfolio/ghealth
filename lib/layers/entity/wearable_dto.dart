
import 'package:ghealth_app/layers/entity/status_dto.dart';

class WearableDTO {
  final StatusDTO statusDTO;
  final dynamic data;

  WearableDTO({
    required this.statusDTO,
    this.data,
  });

  factory WearableDTO.fromJson(Map<String, dynamic> json) {
    return WearableDTO(
      statusDTO: StatusDTO.fromJson(json['status']),
      data: json['data'],
    );
  }
}