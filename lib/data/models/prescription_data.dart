/// 처방 클래스
class PrescriptionData {
  /// 약 이미지 경로
  late String imagePath;

  /// 제조일자
  late String dateOfManufacture;

  /// 제품명
  late String productName;

  PrescriptionData(
      {required this.imagePath,
      required this.dateOfManufacture,
      required this.productName});
}
