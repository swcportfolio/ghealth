
class Constants {
  static const appName = 'GHealth';
  static const appVersion = '1.0.2';

  static const List<String> targetStepsList = [
    '1000', '2000', '3000', '4000', '5000',
    '6000', '7000', '8000', '9000', '10000',
    '15000', '20000', '25000', '30000',
    '35000', '40000', '45000', '50000',
    '55000', '60000',
  ];

  static const List<String> targetSleepList = [
    '1', '2', '3', '4', '5',
    '6', '7', '8', '9', '10',
  ];

  /// 검사 항목 이름 아이템 리스트
  static const urineNameItemList  = [
    '잠혈', '빌리루빈',
    '우로빌리노겐', '케톤체',
    '단백질', '아질산염',
    '포도당', '산성도',
    '비중', '백혈구',
    '비타민',
  ];
}

enum ScreeningsDataType {
  vision('시력'),
  bloodPressure('혈압'),
  weight('몸무게'),
  height('키'),
  hearingAbility('청력'),
  waistCircumference('허리둘레'),
  bodyMassIndex('체질량지수');

  const ScreeningsDataType(this.label);

  final String label;

  static ScreeningsDataType strToEnum(String str) {
    return ScreeningsDataType.values.firstWhere((e) => e.label == str);
  }
}
enum BloodDataType {
  hemoglobin('혈색소', '범위'),
  fastingBloodSugar('공복혈당', '미만'),
  totalCholesterol('총콜레스테롤', '미만'),
  highDensityCholesterol('고밀도 콜레스테롤', '이상'),
  neutralFat('중성지방', '미만'),
  lowDensityCholesterol('저밀도 콜레스테롤', '미만'),
  serumCreatinine('혈청 크레아티닌', '이하'),
  shinsugularFiltrationRate('신사구체여과율', '이상'),
  astSgot('AST(SGOT)', '이하'),
  altSGpt('ALT(SGPT)', '이하'),
  gammaGtp('감마지피티(y-GPT)', '이하');

  const BloodDataType(this.label, this.inequalitySign);

  final String label;
  final String inequalitySign;

  static BloodDataType strToEnum(String str) {
    return BloodDataType.values.firstWhere((e) => e.label == str);
  }
}

/// 건강검진 기록 enum type class
enum HealthReportType {
  eye('d008','시력', 0.43), //시력
  bloodPressure('d013', '혈압',  0.5), //혈압
  bloodSugar('d011', '혈당',  0.35), //혈당
  heightWeight('d001','키,몸무게',  0.55), //키 몸무게
  bodyComposition('d007', '체성분',  0.8), //체성분
  brains('d016', '두뇌',  0.8), //두뇌
  dementia('d017', '치매',  0.4), //치매
  brainWaves('d018', '뇌파',  0.5), //뇌파
  pee('d012', '소변',  0.8), //소변
  boneDensity('d014', '골밀도',  0.7); //골밀도

  const HealthReportType(this.id, this.name, this.ratio);

  final String id;
  final String name; //
  final double ratio; // bottom sheet 높이 비율
}

