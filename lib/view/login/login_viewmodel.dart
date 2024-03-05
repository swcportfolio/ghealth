// ignore_for_file: use_build_context_synchronously
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:ghealth_app/data/repository/post_repository.dart';
import 'package:ghealth_app/utils/etc.dart';
import 'package:ghealth_app/view/home/home_frame_view.dart';
import 'package:ghealth_app/widgets/dialog.dart';
import 'package:ghealth_app/widgets/frame.dart';

import '../../data/enum/snackbar_status_type.dart';
import '../../data/models/send_message_response.dart';
import '../../data/models/user_response.dart';
import '../../main.dart';
import '../../utils/snackbar_utils.dart';
import '../../utils/validation.dart';

class LoginViewModel extends ChangeNotifier {
  late BuildContext context;
  LoginViewModel(this.context);

  final _postRepository = PostRepository();

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

  TextEditingController get phoneController => _phoneController;
  TextEditingController get certificationController => _certificationController;
  bool get isMessageSent => _isMessageSent;
  bool get isSendMessageProgress => _isSendMessageProgress;
  bool get isStartTimer => _isStartTimer;
  int get minutes => _minutes;
  int get seconds => _seconds;


  /// 전화번호로 인증 메시지를 보내는 메서드
  handleSendMessage() async {
    if (!Validation.isValidTelNumber(phoneController, context)) {
      return;
    }
    startSendMessageProgress(); // 인증 메시지 발송 프로그래스 시작

    try {
      SendMessageResponse response = await _postRepository
                   .sendAuthMessageDio({'tel': _phoneController.text});

      endSendMessageProgress(); // 인증 메시지 발송 프로그래스 종료

      if (response.status.code == '200') {
        // 성공시 처리
        SnackBarUtils.showBGWhiteSnackBar(
            '인증번호가 발송되었습니다.', context, seconds: 3);

        logger.d('[handleSendMessage] => 인증번호 메시지 발송!');

        _resetTimer(); // 타이머 초기화
        _startTimer(); // 타이머 시작
        _isMessageSent = true;
        notifyListeners();
      } else {
        // 실패 시 처리
        if(response.status.message.contains('3분이내')){
          SnackBarUtils.showStatusSnackBar(
              message: '3분이 지난 후 다시 시도해주세요.',
              context: context,
              statusType: SnackBarStatusType.failure
          );
        } else {
          SnackBarUtils.showStatusSnackBar(
              message: '인증번호 발송 실패, 다시 시도해주세요.',
              context: context,
              statusType: SnackBarStatusType.failure
          );
        }
        logger.e('=> 발송 실패! ${response.status.message}');
      }
    } on DioException catch (dioError) {
      // 예외 처리
      endSendMessageProgress();
      logger.e('=> dioError: $dioError');
      SnackBarUtils.showStatusSnackBar(
          message: '인증번호 발송 실패, 다시 시도해주세요.',
          context: context,
          statusType: SnackBarStatusType.failure
      );

    } catch (error) {
      endSendMessageProgress();
      logger.e('=> error: $error');
      SnackBarUtils.showStatusSnackBar(
          message: '인증번호 발송 실패, 다시 시도해주세요.',
          context: context,
          statusType: SnackBarStatusType.failure
      );
    }
  }

  /// 로그인을 처리하는 메서드
  handleLogin() async {
    ///@임시
    if(_phoneController.text == '01077778888'){
      _certificationController.text = '12345';
    }
    if (!Validation.isValidTelNumber(_phoneController, context)) {
      return;
    }
    if (!Validation.isValidCertificationCode(certificationController, context)) {
      return;
    }
    try {
      LoginResponse response = await _postRepository.loginDio({
        'tel': _phoneController.text,
        'authCode': _certificationController.text
      });

      if (response.status.code == '200') {
        // 로그인 성공 시 처리
        logger.i('=> Login Success!');

        // 사용자 인증 정보 설정
        Authorization().setValues(
            newUserID: response.data!.userID,
            newUserName: response.data!.userName,
            newToken: response.data!.token,
            newGender: response.data!.gender,
        );
        Authorization().setStringData();
        logger.i(Authorization().toString());

        SnackBarUtils.showStatusSnackBar(
            message: '로그인 완료!   ${response.data!.userName}님 반갑습니다.',
            context: context,
            statusType: SnackBarStatusType.success
        );
        Frame.doPageAndRemoveUntil(context, const HomeFrameView()); // 홈화면 전환

      } else if(response.status.code == 'ERR_LOGIN'){

        if(response.data == ''){ // 코드를 잘못 입력
          logger.e('=> 로그인 코드 및 유효기간 만료');
          CustomDialog.showMyDialog(
              title: '인증 코드',
              content: '코드를 잘못 입력되었거나\n유효기간이 만료된 코드입니다.',
              mainContext: context

          );
        } else if (response.data.toString().contains('전화번호')){
          logger.e('=> 전화번호가 잘못 입력되었거나 회원가입되지 않은 전화번호입니다.');
          CustomDialog.showMyDialog(
              title: '회원 오류',
              content: '전화번호가 잘못 입력되었거나\n회원가입되지 않은 전화번호입니다.',
              mainContext: context
          );
        } else {
          logger.e('=> response.data 로그인 그외 에러!');
          SnackBarUtils.showDefaultSnackBar('서버가 불안정합니다. 다시 시도 바랍니다.', context);
        }
      } else {
        logger.e('=> response.data 로그인 그외 에러!');
        SnackBarUtils.showDefaultSnackBar('서버가 불안정합니다. 다시 시도 바랍니다.', context);
      }
    } on DioException catch (dioError) {
      // 예외 처리
      SnackBarUtils.showDefaultSnackBar('서버가 불안정합니다. 다시 시도 바랍니다.', context);
      logger.e('=> dioError: ${dioError.toString()}');
    } catch (error) {
      SnackBarUtils.showDefaultSnackBar('서버가 불안정합니다. 다시 시도 바랍니다.', context);
      logger.e('=> dioError: ${error.toString()}');
    }
  }

  /// 인증 메시지 발송 중 프로그래스를 시작하는 메서드
  void startSendMessageProgress() {
    _isSendMessageProgress = true;
    notifyListeners();
  }

  /// 인증 메시지 발송 중 프로그래스를 종료하는 메서드
  void endSendMessageProgress() {
    _isSendMessageProgress = false;
    notifyListeners();
  }

  /// 타이머 시작 메서드
  void _startTimer() {
    _isStartTimer = true;
    Future.delayed(const Duration(seconds: 1), _updateTimer);
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
        Future.delayed(const Duration(seconds: 1), _updateTimer);
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