import '../../utils/etc.dart';
import '../../utils/text_formatter.dart';
import 'health_screening_data.dart';

class MetrologyInspection {
  String _visionOld = '-';
  String _visionRight = '-';
  String _visionLeft = '-';

  String _hearingAbilityOld = '-';
  String _hearingAbilityRight = '-';
  String _hearingAbilityLeft = '-';

  String _bloodPressure= '-';
  String _weight= '-';
  String _height= '-';
  String _waistCircumference = '-';
  String _bodyMassIndex = '-';
  String _issuedDate = '-';

  String? get issuedDate => _issuedDate;
  set issuedDate(String? value) => _issuedDate = value!;

  String? get visionOld => _visionOld;
  set visionOld(String? value) => _visionOld = Etc.removeAfterSpace(value!);

  String? get visionRight => _visionRight;
  set visionRight(String? value) => _visionRight = Etc.removeAfterSpace(value!);

  String? get visionLeft => _visionLeft;
  set visionLeft(String? value) => _visionLeft = Etc.removeAfterSpace(value!);

  String? get hearingAbilityOld => _hearingAbilityOld;
  set hearingAbilityOld(String? value) => _hearingAbilityOld = Etc.removeAfterSpace(value!);

  String? get hearingAbilityRight => _hearingAbilityRight;
  set hearingAbilityRight(String? value) => _hearingAbilityRight = Etc.removeAfterSpace(value!);

  String? get hearingAbilityLeft => _hearingAbilityLeft;
  set hearingAbilityLeft(String? value) => _hearingAbilityLeft = Etc.removeAfterSpace(value!);

  String? get bloodPressure => _bloodPressure;
  set bloodPressure(String? value) => _bloodPressure = Etc.removeAfterSpace(value!);

  String? get weight => _weight;
  set weight(String? value) => _weight = Etc.removeAfterSpace(value!);

  String? get height => _height;
  set height(String? value) => _height = Etc.removeAfterSpace(value!);

  String? get waistCircumference => _waistCircumference;
  set waistCircumference(String? value) => _waistCircumference = Etc.removeAfterSpace(value!);

  String? get bodyMassIndex => _bodyMassIndex;
  set bodyMassIndex(String? value) => _bodyMassIndex = Etc.removeAfterSpace(value!);

  void parseFromHealthScreeningList(List<HealthScreeningData> healthScreeningList) {
    for (HealthScreeningData value in healthScreeningList) {
      String dataName = value.dataName;
      String dataValue = Etc.removeAfterSpace(value.dataValue);

      switch (dataName) {
        case '계측검사_시력':
          visionOld = dataValue;
          issuedDate = TextFormatter.defaultDateFormat(value.issuedDate);
          break;
        case '계측검사_시력_우':
          visionRight = dataValue;
          issuedDate = TextFormatter.defaultDateFormat(value.issuedDate);
          break;
        case '계측검사_시력_좌':
          visionLeft = dataValue;
          issuedDate = TextFormatter.defaultDateFormat(value.issuedDate);
          break;
        case '계측검사_청력':
          hearingAbilityOld = dataValue;
          break;
        case '계측검사_청력_우':
          hearingAbilityRight = dataValue;
          break;
        case '계측검사_청력_좌':
          hearingAbilityLeft = dataValue;
          break;

        case '계측검사_혈압':
          bloodPressure = dataValue;
          break;
        case '계측검사_몸무게':
          weight = dataValue;
          break;
        case '계측검사_키':
          height = dataValue;
          break;
        case '계측검사_허리둘레':
          waistCircumference = dataValue;
          break;
        case '계측검사_체질량지수':
          bodyMassIndex = dataValue;
          break;
        default:
        // 처리하지 않는 데이터명의 경우 아무 동작도 하지 않음
          break;
      }
    }
  }

}
