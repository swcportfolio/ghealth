import '../../utils/etc.dart';
import 'health_screening_data.dart';

class MetrologyInspection {
  String? _vision;
  String? _bloodPressure;
  String? _weight;
  String? _height;
  String? _hearingAbility;
  String? _waistCircumference;
  String? _bodyMassIndex;
  String? _issuedDate;

  String? get issuedDate => _issuedDate;
  set issuedDate(String? value) => _issuedDate = value!;

  String? get vision => _vision;
  set vision(String? value) => _vision = Etc.removeAfterSpace(value!);

  String? get bloodPressure => _bloodPressure;
  set bloodPressure(String? value) => _bloodPressure = Etc.removeAfterSpace(value!);

  String? get weight => _weight;
  set weight(String? value) => _weight = Etc.removeAfterSpace(value!);

  String? get height => _height;
  set height(String? value) => _height = Etc.removeAfterSpace(value!);

  String? get hearingAbility => _hearingAbility;
  set hearingAbility(String? value) => _hearingAbility = Etc.removeAfterSpace(value!);

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
          vision = dataValue;
          issuedDate = Etc.defaultDateFormat(value.issuedDate);
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
        case '계측검사_청력':
          hearingAbility = dataValue;
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

  @override
  String toString() {
    return 'MetrologyInspection{_vision: $_vision, _bloodPressure: $_bloodPressure, _weight: $_weight, _height: $_height, _hearingAbility: $_hearingAbility, _waistCircumference: $_waistCircumference, _bodyMassIndex: $_bodyMassIndex}';
  }
}
