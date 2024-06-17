


const String baseUrl = 'http://api.ghealth.or.kr';


/// 로그인
const String loginApiUrl = '$baseUrl/ws/public/user/login';

/// 로그아웃 URL
const String logoutApiUrl = '$baseUrl/ws/private/user/logout';

/// 인증번호 메시지 전송 URL
const String sendAuthApiUrl = '$baseUrl/ws/public/send/auth/message';

/// Authorization 토큰 유효성 체크 URL
const String checkTokenApiUrl = '$baseUrl/ws/private/user/auth/check';

/// 나의건강검진 마이데이터 요약 정보 URL
const String summaryApiUrl = '$baseUrl/ws/private/health/summary';

/// 모든 투약정보 리스트 조회 Url
const String medicationInfoApiUrl = '$baseUrl/ws/private/health/mediacationinfo'; // 'a'오타

/// 처방약 상세 정보 조회 URL
const String drugInfoApiUrl = '$baseUrl/ws/private/health/drug/info';

/// 혈액검사 이력 정보 조회 URL
const String bloodHistoryApiUrl = '$baseUrl/ws/private/health/blood';

/// 계측 이력 정보 조회 URL
const String physicalHistoryApiUrl = '$baseUrl/ws/private/health/instrumentaion'; //'t' 오타

/// 나의 일상 기록 건강관리소 방문 날짜 리스트 URL
const String getVisitDateApiUrl = '$baseUrl/ws/private/lifelog/date';

/// 라이프로그 건강관리소 신체검사 결과 조회 URL
const String lifeLogReulstApiUrl = '$baseUrl/ws/private/lifelog'; // 'a'오타

/// 내 최근 예약 현황 조회 URL
const String reservationRecentApiUrl = '$baseUrl/ws/private/reservation';

/// 방문예약 히스트로 조회 URL
const String reservationHistoryApiUrl = '$baseUrl/ws/private/reservation/history';

/// 방문예약 휴일 날짜 조회 URL
const String reservationDayOffApiUrl = '$baseUrl/ws/public/reservation/dayoff';

/// 예약 가능한 시간 조회 URL
const String reservationPossibleApiUrl = '$baseUrl/ws/public/reservation/time';

/// 예약 저장 URL
const String reservationSaveApiUrl = '$baseUrl/ws/private/reservation';

/// 예약 취소 URL
const String reservationCancelApiUrl = '$baseUrl/ws/private/reservation';

/// AI 건강예측 결과 데이터 가져오기 URL
const String getAiHealthApiUrl = '$baseUrl/ws/private/ai/mydata/predict';

/// 헬스 수집 데이터 저장 URL
const String saveHealthApiUrl = '$baseUrl/ws/private/wearable/';

/// 포인트 히스토리 리스트 가져오기 URL
const String getPointHistoryApiUrl = '$baseUrl/ws/private/point/history';

/// 추천 상품 가져오기 URL
const String getProductApiUrl = '$baseUrl/shop/recommended';

/// 총 포인트 가져오기 URL
const String getTotalPointApiUrl = '$baseUrl/ws/private/point';



