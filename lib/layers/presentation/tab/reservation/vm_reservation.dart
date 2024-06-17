
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_custom_dialog.dart';
import 'package:intl/intl.dart';

import '../../../../common/util/dio/dio_exceptions.dart';
import '../../../../common/util/nav.dart';
import '../../../../common/util/snackbar_utils.dart';
import '../../../../main.dart';
import '../../../domain/usecase/ghealth/reservation_usecase.dart';
import '../../../entity/reservation_dto.dart';
import '../../../model/authorization_test.dart';
import '../../../model/enum/region_type.dart';
import '../../auth/login_view.dart';

class ReservationViewModelTest extends ChangeNotifier {
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';
  BuildContext context;

  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  /// 지역 선택 토클 초기값
  int _toggleIndex = 0;

  ReservationViewModelTest(this.context){
    handleMultipleDayOffReservations();
    getRecentReservation();
  }

  /// 내 최근 예약 내역 클래스
  ReservationDataDTO _reservationRecent = ReservationDataDTO();

  /// 달력- 선택된 날짜 DateTime
  late DateTime selectedDay = DateTime.now();

  /// 달력 선택된 날짜 기준으로 포커싱 날짜
  DateTime focusedDay = DateTime.now().add(const Duration(days: 1));
  final List<String> sampleTimeList = ['09:00','10:00','11:00','13:30','14:30','15:30','16:30'];
  List<DateTime> _dayOffDateList = [];
  List<String> _dayOffDateStringList = [];
  List<String> _possibleDateTime = [];

  /// 선택한 시간
  String? _selectedTime;

  /// 예약 날짜 선택지 Visible
  bool _isVisibleSelectTime = false;

  /// 예약 버튼 Visible
  bool _isVisibleReservationBtn = false;

  /// 지역타입 - default value [RegionType.donggu]
  RegionType _currentRegionType = RegionType.donggu;

  /// 예약 시간 선택 여부 bool 리스트
  late List<bool> _isSelectedList;

  /// 예약 화면 스크롤 컨트롤러
  final _controller = ScrollController();

  ReservationDataDTO? get reservationRecent => _reservationRecent;
  ScrollController get controller => _controller;
  List<DateTime> get dayOffDateList => _dayOffDateList;
  List<String> get possibleDateTime => _possibleDateTime;
  List<bool> get isSelectedList => _isSelectedList;
  bool get isVisibleSelectTime => _isVisibleSelectTime;
  bool get isVisibleReservationBtn => _isVisibleReservationBtn;
  String? get selectedTime => _selectedTime;
  int get toggleIndex => _toggleIndex;
  RegionType get currentRegionType => _currentRegionType;


  /// 예약화면 초기화
  /// 예약이 완료되거나, 예약이 취소했을경우 화면 갱신을위해 필요하다.
  initScreen(){
    _toggleIndex = 0;
    _currentRegionType = RegionType.donggu;
    _dayOffDateStringList.clear();

    getRecentReservation(); // 최근 내역가져오기
    _isVisibleSelectTime = false; // 시간선택지 Vis 초기화
    _isVisibleReservationBtn = false; // 버튼 Vis 초기화
    selectedDay = DateTime.now();
    focusedDay = DateTime.now().add(const Duration(days: 1));
    _possibleDateTime.clear();
    _selectedTime = null;
    notifyListeners();
  }


  /// 최근 예약 내역 가져오기
  Future<void> getRecentReservation() async {
    try{
        final reservationRecentDTO = await ReservationRecentUseCase().execute();

        if (reservationRecentDTO?.status.code == '200' && reservationRecentDTO?.data != null) {
          _reservationRecent = reservationRecentDTO!.data;
          _isLoading = false;
          notifyListeners();
        } else {
          const msg = '예약 내역이 없습니다.';
          notifyError(msg);
        }
      } on DioException catch (e) {
        logger.e(e);
        final msg = DioExceptions.fromDioError(e).toString();
        notifyError(msg);
      } catch (e) {
        logger.e(e);
        const msg = '죄송합니다.\n예기치 않은 문제가 발생했습니다.';
        notifyError(msg);
      }
  }


  /// 예약 휴일 리스트 가져오기
  Future<void> getReservationDayOff(DateTime date) async {
    try{
      final reservationDayOffDTO = await ReservationDayOffUseCase().execute({
            'serviceType': 'lifelog',
            'orgType': _currentRegionType.label,
            'year': date.year,
            'month': date.month
          });

      if (reservationDayOffDTO?.status.code == '200' && reservationDayOffDTO?.data != null) {
        List<String> newDayOff = List.of(reservationDayOffDTO!.data);
        _dayOffDateStringList.addAll(newDayOff);
        _dayOffDateStringList = _dayOffDateStringList.toSet().toList(); // 중복 제거 후 할당

        // 날짜 문자열을 DateTime으로 변환
        _dayOffDateList = _dayOffDateStringList.map((dateString) {
          return DateFormat('yyyy-MM-dd').parse(dateString);
        }).toList();

        notifyListeners();
      } else {
        logger.i('휴일 리스트를 가져오지 못했습니다.');
      }
    } on DioException catch (e) {
      logger.e(e);
      final msg = DioExceptions.fromDioError(e).toString();
      notifyError(msg);
    } catch (e) {
      logger.i(e);
      const msg = '죄송합니다.\n예기치 않은 문제가 발생했습니다.!';
      notifyError(msg);
    }
  }


  /// 예약가능 시간 조회
  Future<void> handlePossibleReservation(DateTime date) async {
    try{
     ReservationPossibleDTO? response = await ReservationPossibleUseCase().execute({
        'serviceType': 'lifelog',
        'orgType': _currentRegionType.label,
        'reservationDate': DateFormat('yyyy-MM-dd').format(date)
      });

      if(response?.status.code == '200' && response?.data != null){
        List<String> reservationTimeStrings = response!.data.map((reservationTimeData) {
          return reservationTimeData.reservationTime;
        }).toList();
        _isVisibleSelectTime = true;
        _possibleDateTime = reservationTimeStrings;
        _isSelectedList = List.filled(_possibleDateTime.length, false);
        logger.i(_possibleDateTime);
      }
      notifyListeners();

    } on DioException catch (e) {
      final msg = DioExceptions.fromDioError(e).toString();
      notifyError(msg);
    } catch (e) {
      const msg = '죄송합니다.\n예기치 않은 문제가 발생했습니다.';
      notifyError(msg);
    }
  }


  /// 오늘 기준 3개월치의 휴일을 서버로부터 가져온다.
  Future<void> handleMultipleDayOffReservations() async {
    DateTime now = DateTime.now();
    for (int i = 0; i < 3; i++) {
      await getReservationDayOff(DateTime(now.year, now.month + i));
    }
  }


  /// 예약 저장
  Future<void> handleSaveReservation() async {
    Map<String, dynamic> toMap = {
      'serviceType': 'lifelog',
      'orgType': _currentRegionType.label,
      'userID': AuthorizationTest().userID,
      'reservationDate': DateFormat('yyyy-MM-dd').format(selectedDay),
      'reservationTime': _selectedTime!,
    };

    try {
      ReservationStatueDTO? response
              = await ReservationSaveUseCase().execute(toMap);

      if(response?.status.code == '200'){
        initScreen();
        _showReservationDialog('방문 예약이 완료되었습니다.');
      }
      else if(response?.status.code == 'ERR_MS_6003'){
        _showReservationDialog('이미 예약되어 있는 날짜입니다.');
      } else {
        _showReservationDialog('방문 예약이 정상적으로\n처리되지 못했습니다.');
      }

    } on DioException catch (e) {
      logger.i(e.message);
      _showReservationDialog('방문 예약이 정상적으로\n처리되지 못했습니다.');
    } catch (e) {
      _showReservationDialog('방문 예약이 정상적으로\n처리되지 못했습니다.');
    }
  }


  /// 예약 취소
  Future<void> handleCancelReservation(int reservationIdx, RegionType orgType) async {
    try {
      ReservationStatueDTO? response =
          await ReservationCancelUseCase().execute({
        "serviceType": "lifelog",
        "reservationIdx": reservationIdx,
        "orgType": orgType.label,
      });
      if (response?.status.code == '200') {
        _showReservationDialog('방문 예약이 취소되었습니다.');
        initScreen();
      } else {
        _showReservationDialog('방문 예약 취소가\n정상적으로 처리되지 못했습니다.');
      }
    } on DioException catch (e) {
      logger.e(e);
      _showReservationDialog('방문 예약 취소가\n정상적으로 처리되지 못했습니다.');
    } catch (e) {
      logger.e(e);
      _showReservationDialog('방문 예약 취소가\n정상적으로 처리되지 못했습니다.');
    }
  }


  /// 예약 다이얼로그를 표시합니다.
  void _showReservationDialog(String message) {
    CustomDialog.showMyDialog(
      title: '예약',
      content: message,
      mainContext: context,
    );
  }


  /// 사용자가 달력에서 날짜를 선택했을 때 호출되는 메서드입니다.
  ///
  /// 선택된 날짜와 포커싱된 날짜를 업데이트하고,
  /// 선택된 예약 시간과 예약 버튼의 가시성을 초기화합니다.
  /// 그리고 선택된 날짜에 가능한 예약 시간을 처리하고,
  /// 화면을 다시 그리기 위해 리스너들에게 알립니다.
  /// 마지막으로 화면을 스크롤하여 선택된 날짜의 예약 시간을 표시합니다.
  ///
  /// [selectedDay]: 사용자가 선택한 날짜
  /// [focusedDay]: 달력에서 포커싱된 날짜
  onDaySelectedCalendar(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay = selectedDay;
    this.focusedDay = focusedDay;

    // 예약 날짜, 예약버튼 초기화
    _isSelectedList = List.filled(7, false); // Unselect all
    _isVisibleReservationBtn = false;

    handlePossibleReservation(selectedDay);
    notifyListeners();
    scrollerMaxScrollExtent();
  }


  /// 스크롤러를 최대 스크롤 범위로 이동시킵니다.
  scrollerMaxScrollExtent(){
    Future.delayed(const Duration(milliseconds: 500), () {

      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }


  /// 예약 시간을 추출하여 문자열 리스트로 반환합니다.
  List<String> getReservationTime(Map<String, dynamic> json) {
    // "data" 필드에 해당하는 리스트 추출
    List<dynamic> dataList = json['data'];

    // 각 객체의 "reservationTime" 필드를 추출하여 String 리스트 생성
    List<String> reservationTimes = dataList.map((item) {
      return item['reservationTime'].toString();
    }).toList();
    return reservationTimes;
  }


  /// 시간 항목을 선택하거나 선택을 해제하고 선택된 시간을 업데이트합니다.
  onTapSelectItem(int index){
    if(_isSelectedList[index]){
      _isSelectedList[index] = false;
      _selectedTime = null;
      _isVisibleReservationBtn = false;
    } else {
      _isSelectedList = List.filled(_possibleDateTime.length, false); // Unselect all
      _isSelectedList[index] = true;
      _selectedTime = _possibleDateTime[index];
      logger.i('=> 선택된 데이터 시간: $_selectedTime');

      _isVisibleReservationBtn = true;
    }
    notifyListeners();
    scrollerMaxScrollExtent();
  }

  /// 지역 선택 토글
  /// index 값 변경 및 _currentRegionType 변경
  onToggle(int? index){
    initScreen();
    _toggleIndex = index ?? 0;
    if(_toggleIndex == 0){
      _currentRegionType = RegionType.donggu;
      _dayOffDateStringList.clear();
      handleMultipleDayOffReservations();

    } else {
      _currentRegionType = RegionType.gwangsangu;
      _dayOffDateStringList.clear();
      handleMultipleDayOffReservations();
    }
  }


  ///TODO: Authorization 기존 data/ 경로에 있는 파일을 사용함
  bool visibleRegionChoice() {
    return AuthorizationTest().userIDOfD != '' && AuthorizationTest().userIDOfG != '';
  }


  /// 사용자의 권한에 따라 지역 유형을 설정합니다.
  ///
  /// 사용자의 권한에 따라 로그인된 사용자의 지역을 결정하고 이를 반환합니다.
  /// 만약 모든 사용자의 권한이 만료되었거나 로그아웃된 경우,
  /// 재로그인을 유도하고 동구 지역을 반환합니다.
  setRegionType(){
    if(AuthorizationTest().userIDOfD == '' && AuthorizationTest().userIDOfG == ''){
      Future.delayed(const Duration(seconds: 1),(){
        SnackBarUtils.showBGWhiteSnackBar(
            '권한 만료, 재 로그인 필요합니다.', context);
        AuthorizationTest().clean();
        AuthorizationTest().clearSetStringData();
        Nav.doPush(context, const LoginViewTest());
      });
      return RegionType.donggu;
    }
    else if(AuthorizationTest().userIDOfD == ''){
      return RegionType.gwangsangu;
    }
    else {
      return RegionType.donggu;
    }
  }


  /// 에러 처리
  notifyError(String message){
    _isLoading = false;
    _errorMessage = message;
    _isError = true;
    notifyListeners();
  }
}