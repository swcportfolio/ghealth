

//const String baseUrl = 'http://106.251.70.71:50011';
//const String baseUrl = 'http://192.168.0.54:50011';
const String baseUrl = 'http://api.ghealth.or.kr';

/// Authorization 토큰 유효성 체크 URL
const String checkAuthApiUrl = '$baseUrl/ws/private/user/auth/check';

/// 인증번호 메시지 전송 URL
const String sendAuthMessageApiUrl = '$baseUrl/ws/public/send/auth/message';

/// 로그인 URL
const String loginApiUrl = '$baseUrl/ws/public/user/login';

/// 마이데이터 요약 정보 URL
const String healthSummaryApiUrl = '$baseUrl/ws/private/health/summary';

/// 계측 이력 정보 조회 URL
const String healthInstrumentationApiUrl = '$baseUrl/ws/private/health/instrumentaion'; //'t' 오타

/// 혈액검사 이력 정보 조회 URL
const String healthBloodApiUrl = '$baseUrl/ws/private/health/blood';

/// 모든 투약정보 리스트 조회 Url
const String healthMedicationInfoApiUrl = '$baseUrl/ws/private/health/mediacationinfo'; // 'a'오타

/// 라이프로그 건강검진 결과 조회 URL
const String healthLifeLogApiUrl = '$baseUrl/ws/private/lifelog'; // 'a'오타

/// 내 최근 예약 현황 조회 URL
const String recentReservationApiUrl = '$baseUrl/ws/private/reservation';

/// 방문예약 히스트로 조회 URL
const String historyReservationApiUrl = '$baseUrl/ws/private/reservation/history';

/// 방문예약 휴일 날짜 조회 URL
const String dayOffReservationApiUrl = '$baseUrl/ws/public/reservation/dayoff';

/// 예약 가능한 시간 조회 URL
const String possibleReservationApiUrl = '$baseUrl/ws/public/reservation/time';

/// 예약 저장 URL
const String saveReservationApiUrl = '$baseUrl/ws/private/reservation';

/// 예약 취소 URL
const String cancelReservationApiUrl = '$baseUrl/ws/private/reservation';

/// 로그아웃 URL
const String logoutApiUrl = '$baseUrl/ws/private/user/logout';

/// 헬스 수집 데이터 저장 URL
const String saveHealthDataApiUrl = '$baseUrl/ws/private/wearable/';
