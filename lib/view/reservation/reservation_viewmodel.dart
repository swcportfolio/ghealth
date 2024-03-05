
// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:ghealth_app/data/models/reservation_recent_response.dart';
import 'package:ghealth_app/data/repository/post_repository.dart';
import 'package:ghealth_app/utils/etc.dart';
import 'package:ghealth_app/widgets/dialog.dart';
import 'package:intl/intl.dart';

import '../../data/enum/snackbar_status_type.dart';
import '../../data/models/reservation_data.dart';
import '../../data/models/reservation_dayoff_response.dart';
import '../../data/models/reservation_default_response.dart';
import '../../data/models/reservation_possible_response.dart';
import '../../main.dart';
import '../../utils/snackbar_utils.dart';

class ReservationViewModel extends ChangeNotifier {

  ReservationViewModel(this.context);
  late BuildContext context;
  final _controller = ScrollController();

  /// Repository 객체
  final _postRepository = PostRepository();

  /// 내 최근 예약 내역 클래스
  ReservationData recentReservationData = ReservationData();

  /// 달력- 선택된 날짜 DateTime
  late DateTime selectedDay = DateTime.now();

  /// 달력= 선택된 날짜 기준으로 포커싱 날짜
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

  List<DateTime> get dayOffDateList => _dayOffDateList;
  List<String> get possibleDateTime => _possibleDateTime;

  bool get isVisibleSelectTime => _isVisibleSelectTime;
  bool get isVisibleReservationBtn => _isVisibleReservationBtn;
  ScrollController get controller => _controller;
  String? get selectedTime => _selectedTime;

  late List<bool> _isSelectedList;
  List<bool> get isSelectedList => _isSelectedList;

  /// 예약화면 초기화
  /// 예약이 완료되거나, 예약이 취소했을경우 화면 갱신을위해 필요하다.
  initScreen(){
    handleRecentReservation(); // 최근 내역가져오기
    _isVisibleSelectTime = false; // 시간선택지 Vis 초기화
    _isVisibleReservationBtn = false; // 버튼 Vis 초기화
    selectedDay = DateTime.now();
    focusedDay = DateTime.now().add(const Duration(days: 1));
    _possibleDateTime.clear();
    _selectedTime = null;
    notifyListeners();
  }

  /// 최근 예약 내역 가져오기
  Future<void> handleRecentReservation() async {
    handleMultipleDayOffReservations();

    try{
      ReservationRecentResponse response = await _postRepository
          .getRecentReservationDio();

      if (response.status.code == '200') {
        recentReservationData = response.data!;
        logger.i('=> ${response.data}');
      }

      notifyListeners();
    } on DioException catch (dioError){
      logger.e('=> dioError: ${dioError.message}');
      throw Exception(dioError);
    } catch (error){
      logger.e('=> error: ${error.toString()}');
      throw Exception(error);
    }
  }

  /// 예약 휴일 리스트 가져오기
  Future<void> handleDayOffReservation(DateTime date) async {
    try{
      ReservationDayOffResponse response =
          await _postRepository.getDayOffReservationDio(date);

      if (response.status.code == '200') {
        List<String> newDayOff = List.of(response.data);
        _dayOffDateStringList.addAll(newDayOff);
        _dayOffDateStringList = _dayOffDateStringList.toSet().toList(); // 중복 제거 후 할당

        // 날짜 문자열을 DateTime으로 변환
        _dayOffDateList = _dayOffDateStringList.map((dateString) {
          return DateFormat('yyyy-MM-dd').parse(dateString);
        }).toList();
        logger.i(_dayOffDateList.toString());
      }
      notifyListeners();

    } on DioException catch (dioError){
      logger.i('=> $dioError');
      throw Exception(dioError);
    }
  }

  /// 예약가능 시간 조회
  Future<void> handlePossibleReservation(DateTime dateTime) async {
    try{
      ReservationPossibleResponse response
          = await _postRepository.getPossibleReservationDio(dateTime);

      if(response.status.code == '200'){
        List<String> reservationTimeStrings = response.data.map((reservationTimeData) {
          return reservationTimeData.reservationTime;
        }).toList();
        _isVisibleSelectTime = true;
        _possibleDateTime = reservationTimeStrings;
        _isSelectedList = List.filled(_possibleDateTime.length, false);
        logger.i(_possibleDateTime);
      }
      notifyListeners();

    } on DioException catch (dioError) {
      logger.i('=> $dioError');
      throw Exception(dioError);
    }
  }

  /// 3개월치의 휴일을 가져온다.
  Future<void> handleMultipleDayOffReservations() async {
    DateTime now = DateTime.now();
    for (int i = 0; i < 3; i++) {
      await handleDayOffReservation(DateTime(now.year, now.month + i));
      // 여기서 필요한 추가 작업을 수행할 수 있습니다.
    }
  }

  /// 예약 저장
  Future<void> handleSaveReservation() async {
    Map<String, dynamic> toMap = {
      'serviceType': 'lifelog',
      'userID': Authorization().userID,
      'reservationDate': DateFormat('yyyy-MM-dd').format(selectedDay),
      'reservationTime': _selectedTime!,
    };

    try {
      DefaultResponse response = await _postRepository
          .saveReservationDio(toMap);

      if(response.status.code == '200'){
        SnackBarUtils.showStatusSnackBar(
          message: '예약이 완료 되었습니다.',
          context: context,
          statusType: SnackBarStatusType.success,
        );
        initScreen();
      }
      else if(response.status.code == 'ERR_MS_6003'){
        CustomDialog.showMyDialog(
          title: '예약',
          content: '이미 예약되어 있는 날짜입니다',
          mainContext: context,
        );
      } else {
        CustomDialog.showMyDialog(
          title: '예약',
          content: '건강관리소 예약이\n정상적으로 처리되지 못했습니다.',
          mainContext: context,
        );
      }

    } on DioException catch (dioError) {
      logger.i('=> $dioError');
      //throw Exception(dioError);
      CustomDialog.showMyDialog(
        title: '예약',
        content: '건강관리소 예약이\n정상적으로 처리되지 못했습니다.',
        mainContext: context,
      );
    }
  }

  /// 예약 취소
  Future<void> handleCancelReservation(int reservationIdx) async {
    try {
      DefaultResponse response = await _postRepository.cancelReservationDio({
               "serviceType": "lifelog",
               "reservationIdx": reservationIdx
         });

      if(response.status.code == '200'){
        SnackBarUtils.showStatusSnackBar(
            message: '예약이 취소 되었습니다.',
            context: context,
            statusType: SnackBarStatusType.success
        );
        initScreen();
      } else {
        CustomDialog.showMyDialog(
          title: '예약',
          content: '건강관리소 예약 취소가\n정상적으로 처리되지 못했습니다.',
          mainContext: context,
        );
      }

    } on DioException catch (dioError) {
      logger.i('=> $dioError');
      //throw Exception(dioError);
      CustomDialog.showMyDialog(
        title: '예약',
        content: '방문 예약 취소가\n정상적으로 처리되지 못했습니다.',
        mainContext: context,
      );
    }
  }

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

  List<String> getReservationTime(Map<String, dynamic> json) {
    // "data" 필드에 해당하는 리스트 추출
    List<dynamic> dataList = json['data'];

    // 각 객체의 "reservationTime" 필드를 추출하여 String 리스트 생성
    List<String> reservationTimes = dataList.map((item) {
      return item['reservationTime'].toString();
    }).toList();
    return reservationTimes;
  }

  scrollerMaxScrollExtent(){
    Future.delayed(const Duration(milliseconds: 500), () {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  onTapSelectItem(int index){
    if(_isSelectedList[index]){
      _isSelectedList[index] = false;
      _selectedTime = null;
      _isVisibleReservationBtn = false;
    } else {
      _isSelectedList = List.filled(_possibleDateTime.length, false); // Unselect all
      _isSelectedList[index] = true;
      _selectedTime = sampleTimeList[index];
      logger.i('=> 선택된 데이터 시간: $_selectedTime');

      _isVisibleReservationBtn = true;
    }
    notifyListeners();
    scrollerMaxScrollExtent();
  }
}