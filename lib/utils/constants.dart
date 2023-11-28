
class Constants {
  static const appName = 'GHealth';
  static const appVersion = '1.0.0';

  static const List<String> targetStepsList = [
    '1000',
    '2000',
    '3000',
    '4000',
    '5000',
    '6000',
    '7000',
    '8000',
    '9000',
    '10000',
    '15000',
    '20000',
    '25000',
    '30000',
    '35000',
    '40000',
    '45000',
    '50000',
    '55000',
    '60000',
  ];

  static const List<String> targetSleepList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
  ];

  /// 검사 항목 이름 아이템 리스트
  static const urineNameItemList  = [
    '잠혈',
    '빌리루빈',
    '우로빌리노겐',
    '케톤체',
    '단백질',
    '아질산염',
    '포도당',
    '산성도',
    '비중',
    '백혈구',
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
  eye('d008','시력'), //시력
  bloodPressure('d013', '혈압'), //혈압
  bloodSugar('d011', '혈당'), //혈당
  heightWeight('d001','키,몸무게'), //키 몸무게
  bodyComposition('d007', '체성분'), //체성분
  brains('d016', '두뇌'), //두뇌
  dementia('d017', '치매'), //치매
  brainWaves('d018', '뇌파'), //뇌파
  pee('d012', '소변'), //소변
  boneDensity('d014', '골밀도'); //골밀도

  const HealthReportType(this.id, this.name);

  final String id;
  final String name;
}






// bool hasCat = false;
// bool hasLicense = false;
// String? commonSortText;
// int? commonSortIndex;
// String? careSortText;
// int? careSortIndex;

// /// 로컬 알림 상태
// /// 채팅화면에서는 알림이 울리면 안된다.
// bool isNotificationState = true;
//
// /// 화면에서 채팅중인 상대방 닉네임
// /// 실시간으로 채팅중인 상대방을 제외한 나머지 알림은 받아야된다.
// String? currentChatOpponentNickName;
//

//   static const List<String> licenseList = [
//     '수의사',
//     '수의테크니션',
//     '반려동물종합관리사',
//     '반려동물행동교정사',
//     '반려동물생활관리사',
//     '펫매니저',
//     '캣매니저',
//     '펫뷰티션',
//     '반려동물장례코디네이터',
//     '반려동물식품관리사',
//     '반려동물매개심리상담사',
//     '직접입력',
//   ];
//

//
//   static const List<String> careRunningTimeList = [
//     '30분 동안',
//     '1시간 동안',
//     '1시간 30분 동안',
//     '2시간 동안'
//   ];
//
//   static const List<String> fewCatsList = [
//     '다묘경험 없음',
//     '2마리',
//     '3마리',
//     '4마리',
//     '5마리',
//     '6마리',
//     '7마리 이상',
//   ];
//
//   static List<String> catWeightList = List.generate(26, (i) {
//     if(i == 0){
//      return '1kg 미만';
//     } else if(i == 25){
//       return '25kg 초과';
//     } else {
//       return '${i}kg';
//     }
//   });
//
//   static const String defaultProfileImagePath = 'https://firebasestorage.googleapis.com/v0/b/entrustapp-d1f44.appspot.com/o/users%2Fprofile_image.png?alt=media&token=15feb08f-3678-45a6-9db6-af3c7aedc5ae&_gl=1*so92bp*_ga*MjA5MDgxNTQxLjE2OTM5NzY5NDM.*_ga_CW55HF8NVT*MTY5Njk4OTQ4OC41Ni4xLjE2OTY5OTA2ODEuMTYuMC4w';
// }
//
//
// /// 소셜 로그인
// enum SocialLoginType { kakao, apple, google }
//
// /// 집사 지원 - 기본 정보
// /// 집사나이, 경력, 다묘, 묘종, 냥이 생일, 냥이몸무게
// enum BasicInfo { age, year, number, species, birthday, weight }


