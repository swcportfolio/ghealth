import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/layers/entity/login_dto.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_custom_dialog.dart';

import '../../../common/util/snackbar_utils.dart';
import '../../../common/util/validation.dart';
import '../../../main.dart';
import '../../domain/usecase/auth_usecase.dart';
import '../../entity/send_auth_dto.dart';
import '../../model/authorization_test.dart';
import '../../model/enum/snackbar_status_type.dart';
import '../tab/v_tab_frame.dart';

class LoginViewModelTest extends ChangeNotifier {

  /// 휴대폰번호 입력 필드 컨트롤러
  final _phoneController = TextEditingController();

  /// 인증변호 입력 필드 컨트롤러
  final _certificationController = TextEditingController();

  /// 인증번호 메시지 전송 여부
  /// false 경우 인증번호 입력 필드가 보이지 않는다.
  /// true 경우 인증번호 입력 필드가 보인다.
  bool _isMessageSent = false;

  /// 인증번호 전송시 재전송을 방지하기 위한
  /// progress flag
  bool _isSendMessageProgress = false;

  /// 인증번호 전송이 완료되면 다음 전송까지 타이머가 생성되게 된다.
  /// ture: 타이머 시작
  /// flase: 타이머 미시작 및 종료
  bool _isStartTimer = false;

  /// 타이머 3분 설정
  final Duration _duration = const Duration(minutes: 3);
  late int _minutes = 3;
  late int _seconds = 0;

  /// 관리자 임시 아이디, 인증코드
  final adminID = '01077778888';
  final adminCertification = '12345';

  TextEditingController get phoneController => _phoneController;
  TextEditingController get certificationController => _certificationController;
  bool get isMessageSent => _isMessageSent;
  bool get isSendMessageProgress => _isSendMessageProgress;
  bool get isStartTimer => _isStartTimer;
  int get minutes => _minutes;
  int get seconds => _seconds;


  /// 인증번호 발송
  sendAuthMessage(BuildContext context) async {
    if (!Validation.isValidTelNumber(phoneController, context)) {
      return;
    }
    _startSendMessageProgress(); // 인증 메시지 발송 프로그래스 시작

    try {
      SendAuthDTO? response = await SendAuthUseCase()
          .execute({'tel': _phoneController.text});

      _endSendMessageProgress(); // 인증 메시지 발송 프로그래스 종료

      if(context.mounted){
        if (response == null) {
          _endSendMessageProgress();
          SnackBarUtils.showStatusSnackBar(
            message: '인증번호 발송 실패, 다시 시도해주세요.',
            context: context,
            statusType: SnackBarStatusType.failure,
          );
        } else if (response.status.code == '200') {
          // 성공 시 처리
          handleSuccessSendAuth(context);
        } else {
          // 실패 시 처리
          handleFailureSendAuth(context, response.status.message);
        }
      }

    } on DioException catch (dioError) {
      if(context.mounted){
        errorSendAuth(dioError, context);
      }
    } catch (error) {
      if(context.mounted){
        errorSendAuth(error, context);
      }
    }
  }


  /// 인증번호 에러 처리
  void errorSendAuth(error, context){
    _endSendMessageProgress();
    logger.e('=> error: $error');
    SnackBarUtils.showStatusSnackBar(
        message: '인증번호 발송 실패, 다시 시도해주세요.',
        context: context,
        statusType: SnackBarStatusType.failure
    );
  }


  /// 인증번호 발송 성공시 처리
  void handleSuccessSendAuth(BuildContext context) {
    SnackBarUtils.showBGWhiteSnackBar(
        '인증번호가 발송되었습니다.', context, seconds: 3);
    logger.d('[handleSendMessage] => 인증번호 메시지 발송!');
    _resetAndStartTimer();
  }


  /// 인증번호 발송 실패시 처리
  void handleFailureSendAuth(BuildContext context, String? message) {
    String errorMessage = message ?? '인증번호 발송 실패, 다시 시도해주세요.';
    if (errorMessage.contains('3분이내')) {
      errorMessage = '3분이 지난 후 다시 시도해주세요.';
    }
    SnackBarUtils.showStatusSnackBar(
      message: errorMessage,
      context: context,
      statusType: SnackBarStatusType.failure,
    );
    logger.e('=> 발송 실패! $errorMessage');
  }


  /// 로그인
  login(BuildContext context) async {
    // 임시: 휴대폰 번호가 특정 값일 때 자동으로 인증 코드 입력
    if (_phoneController.text == adminID) {
      _certificationController.text = adminCertification;
    }

    // 휴대폰 번호 유효성 검사
    if (!Validation.isValidTelNumber(_phoneController, context)) {
      return;
    }

    // 인증 코드 유효성 검사
    if (!Validation.isValidCertificationCode(_certificationController, context)) {
      return;
    }

    try {
      LoginDTO? response = await LoginUseCase().execute({
        'tel': _phoneController.text,
        'authCode': _certificationController.text,
      });

      if(context.mounted){
        if (response == null) {
          showErrorSnackBar(context, '서버가 불안정합니다. 다시 시도 바랍니다.');
        } else {
          handleLoginResponse(context, response);
        }
      }

    } on DioException catch (dioError) {
      if(context.mounted){
        showErrorSnackBar(context, '서버가 불안정합니다. 다시 시도 바랍니다.');
      }
      logger.e('=> dioError: ${dioError.toString()}');
    } catch (error) {
      if(context.mounted){
        showErrorSnackBar(context, '서버가 불안정합니다. 다시 시도 바랍니다.');
      }
      logger.e('=> Error: ${error.toString()}');
    }
  }


  /// 로그인 응답 처리
  void handleLoginResponse(BuildContext context, LoginDTO response) {
    switch (response.status.code) {
      case '200':
        handleLoginSuccess(context, response);
        break;
      case 'ERR_LOGIN':
        handleLoginError(context, response);
        break;
      default:
        showErrorSnackBar(context, '서버가 불안정합니다. 다시 시도 바랍니다.');
        logger.e('=> Unknown error during login');
        break;
    }
  }


  /// 로그인 성공시 처리
  void handleLoginSuccess(BuildContext context, LoginDTO response) {
    logger.i('=> Login Success Test!');
    logger.i('token Test=> ${response.data!.token}');
    // 타이머 종료
    _resetTimer();

    // 사용자 정보 AuthorizationTest에 저장
    AuthorizationTest().userID = response.data!.userID;
    AuthorizationTest().userName = response.data!.userName;
    AuthorizationTest().token = response.data!.token;
    AuthorizationTest().gender = response.data!.gender;
    AuthorizationTest().userIDOfD = response.data!.userIDOfD;
    AuthorizationTest().userIDOfG = response.data!.userIDOfG;

    // Prefs 사용자 정보 저장
    AuthorizationTest().saveOfLocalPerf();

    SnackBarUtils.showStatusSnackBar(
      message: '로그인 완료!   ${response.data!.userName}님 반갑습니다.',
      context: context,
      statusType: SnackBarStatusType.success,
    );

    Nav.doAndRemoveUntil(context, const TabFrameViewTest()); // 홈화면 전환
  }


  /// 로그인 에러 처리
  void handleLoginError(BuildContext context, LoginDTO response) {
    String errorMessage = _getLoginErrorMessage(response);
    logger.e('=> Login Error: $errorMessage');

    CustomDialog.showMyDialog(
      title: '로그인 오류',
      content: errorMessage,
      mainContext: context,
    );
  }


  /// 로그인 에러 메시지 String
  String _getLoginErrorMessage(LoginDTO response) {
    if (response.data == '') {
      return '코드를 잘못 입력되었거나\n 유효기간이 만료된 코드입니다.';
    } else if (response.data.toString().contains('인증번호')) {
      return '유효하지 않는 인증번호입니다.';
    } else if (response.data.toString().contains('전화번호')) {
      return '전화번호가 잘못 입력되었거나 회원가입되지 않은 전화번호입니다.';
    } else {
      return '서버가 불안정합니다. 다시 시도 바랍니다.';
    }
  }


  /// 에러 스넥바
  void showErrorSnackBar(BuildContext context, String message) {
    logger.e('=> Error: $message');
    SnackBarUtils.showDefaultSnackBar(message, context);
  }


  /// 인증 메시지 발송 중 프로그래스를 시작하는 메서드
  void _startSendMessageProgress() {
    _isSendMessageProgress = true;
    notifyListeners();
  }


  /// 인증 메시지 발송 중 프로그래스를 종료하는 메서드
  void _endSendMessageProgress() {
    _isSendMessageProgress = false;
    notifyListeners();
  }


  /// 타이머 초기화 및 시작
  void _resetAndStartTimer() {
    _resetTimer(); // 타이머 초기화
    _startTimer(); // 타이머 시작
    _isMessageSent = true;
    notifyListeners();
  }


  /// 타이머 시작 메서드
  void _startTimer() {
    _isStartTimer = true;
    Future.delayed(1.seconds, _updateTimer);
  }


  /// 타이머 업데이트 메서드
  void _updateTimer() {
    if (_isStartTimer) {
        if (_seconds > 0) {
          _seconds--;
        } else {
          if (_minutes > 0) {
            _minutes--;
            _seconds = 59;
          } else {
            _isStartTimer = false;
            _minutes = 0;
            _seconds = 0;
          }
        }
        notifyListeners();

      if (_minutes > 0 || _seconds > 0) {
        Future.delayed(1.seconds, _updateTimer);
      } else {
        _isStartTimer = false;
        notifyListeners();
      }
    }
  }


  /// 타이머 초기화 메서드
  void _resetTimer() {
      _isStartTimer = false;
      _minutes = _duration.inMinutes;
      _seconds = _duration.inSeconds % 60;
      notifyListeners();
  }

}