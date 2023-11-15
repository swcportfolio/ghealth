// ignore_for_file: use_build_context_synchronously
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:ghealth_app/data/repository/post_repository.dart';
import 'package:ghealth_app/utils/etc.dart';
import 'package:ghealth_app/view/home/home_frame_view.dart';
import 'package:ghealth_app/widgets/frame.dart';

import '../../data/models/send_message_response.dart';
import '../../data/models/user_response.dart';
import '../../main.dart';
import '../../utils/validation.dart';

class LoginViewModel extends ChangeNotifier {
  late BuildContext context;
  final _postRepository = PostRepository();

  /// 휴대폰번호 입력 필드 컨트롤러
  final _phoneController = TextEditingController(text: '01085208169');

  /// 인증변호 입력 필드 컨트롤러
  final _certificationController = TextEditingController(text:'12345');

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
        Etc.showSnackBar('인증번호가 발송되었습니다.', context);
        logger.d('[handleSendMessage] => 인증번호 메시지 발송!');

        _resetTimer(); // 타이머 초기화
        _startTimer(); // 타이머 시작
        _isMessageSent = true;
        notifyListeners();
      } else {
        // 실패 시 처리
        Etc.showSnackBar(response.status.message, context);
        logger.d('=> 발송 실패! ${response.status.message}');
      }
    } on DioException catch (dioError) {
      // 예외 처리
      endSendMessageProgress();
      logger.e('=> dioError: $dioError');
    } catch (error) {
      endSendMessageProgress();
      logger.e('=> error: $error');
    }
  }

  /// 로그인을 처리하는 메서드
  handleLogin() async {
    if (!Validation.isValidCertificationCode(certificationController, context)) {
      return;
    }

    try {
      // 로그인 요청
      LoginResponse response = await _postRepository.loginDio({
        'tel': _phoneController.text,
        'authCode': _certificationController.text
      });

      if (response.status.code == '200') {
        // 로그인 성공 시 처리
        logger.i('=> Login Success!');

        // 사용자 인증 정보 설정
        Authorization().setValues(
            newUserID: response.data.userID,
            newUserName: response.data.userName,
            newToken: response.data.token,
            newGender: response.data.gender,
        );

        // 홈화면 전환
        Frame.doPageAndRemoveUntil(context, const HomeFrameView());
      }
    } on DioException catch (dioError) {
      // 예외 처리
      Etc.showSnackBar('dioError: ${dioError.toString()}', context);
      logger.e('=> dioError: ${dioError.toString()}');
    } catch (error) {
      Etc.showSnackBar('error: ${error.toString()}', context);
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