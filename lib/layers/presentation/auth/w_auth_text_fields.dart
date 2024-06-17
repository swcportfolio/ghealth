import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/constants/app_constants.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/layers/presentation/auth/vm_login.dart';
import 'package:provider/provider.dart';

import '../../../common/util/scale_font_size.dart';
import '../../model/enum/login_input_type.dart';
import '../widgets/style_text.dart';

class AuthTextFields extends StatelessWidget {
  const AuthTextFields({super.key});

  String get phoneHintText => '휴대폰 번호 \'-\'제외한 11자리';
  String get certificationHintText => '휴대폰 인증번호';
  String get guideFirstText => '• 3분 이내로 인증번호(5자리)를 입력헤주세요.';
  String get guideSecondText => '• 전송되지 않을경우 3분이후 "재전송"버튼을 눌러주세요.';

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModelTest>(
        builder: (context, provider, child) {
          bool visible = provider.isMessageSent;
          return Column(
            children:
            [
              /// 휴대폰 번호 입력 필드
              buildLoginTextField(
                  context: context,
                  hint: phoneHintText,
                  inputType: LoginInputType.phone,
                  controller: provider.phoneController),
              const Gap(AppDim.medium),

              /// 인증번호 입력 필드
              Visibility(
                visible: visible,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  buildLoginTextField(
                    context: context,
                    hint: certificationHintText,
                    inputType: LoginInputType.certification,
                    controller: provider.certificationController,
                  ),
                  const Gap(AppDim.large),

                  /// 가이드 내용1
                  Padding(
                    padding: const EdgeInsets.only(left: AppDim.large),
                    child: StyleText(
                        text: guideFirstText,
                        size: AppDim.fontSizeSmall,
                        color: AppColors.white),
                  ),
                  const Gap(AppDim.xSmall),

                    /// 가이드 내용2
                  Padding(
                    padding: const EdgeInsets.only(left: AppDim.large),
                    child: StyleText(
                      text: guideSecondText,
                      size: AppDim.fontSizeSmall,
                      color: AppColors.white,
                    ),
                  ),
                  const Gap(AppDim.medium),
                ],
              ),
              ),
            ],
          );
        },
      );
  }


  /// 로그인 정보 입력 필드를 만드는 위젯을 생성하는 함수.
  ///
  /// TODO: 입력시 띄워쓰기는 지워줘야된다.
  buildLoginTextField({
    required BuildContext context,
    required String hint,
    required LoginInputType inputType,
    required TextEditingController controller,
  }) {
    return Container(
        height: 60.0,
        margin: const EdgeInsets.symmetric(horizontal: AppDim.medium),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(AppConstants.radius),
        ),
        child: Row(
          children: [
            Expanded(
              child: MediaQuery(
                data: getScaleFontSize(context),
                child: TextField(
                  autofocus: false,
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                      color: Colors.black, decorationThickness: 0),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.only(left: AppDim.xLarge),
                      hintText: hint,
                      hintStyle: const TextStyle(
                          color: AppColors.grey,
                          fontWeight: AppDim.weight500,
                      )
                  ),
                ),
              ),
            ),
            Visibility(
              visible: inputType == LoginInputType.phone ? true : false,
              child: Padding(
                padding: const EdgeInsets.only(right: AppDim.medium),
                child: Consumer<LoginViewModelTest>(
                  builder: (context, provider, child) {
                    bool isProgress = provider.isSendMessageProgress;
                    bool isStartTimer = provider.isStartTimer;
                    int minutes = provider.minutes;
                    int seconds = provider.seconds;

                    bool isMessageSent = provider.isMessageSent; // 인증번호 필드가 활성화 되어 있는가?

                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.sendBgColor,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppConstants.borderRadius,
                          )),
                      onPressed: () => {
                        if(!isProgress && !isStartTimer){
                          FocusScope.of(context).unfocus(),

                          ///TODO: 마스터 계정
                          if(provider.phoneController.text != '01077778888'){
                            provider.sendAuthMessage(context),
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: isProgress
                            ? buildSendMessageProgressIndicator()
                            : isStartTimer
                            ? StyleText(
                            text: (minutes == 0 && seconds == 0)
                                ? '재전송'
                                : '$minutes:${seconds.toString().padLeft(
                                2, '0')}',
                            color: AppColors.blackTextColor,
                            fontWeight: AppDim.weight500,
                        )
                            : StyleText(
                            text: isMessageSent ? '재전송' : '전송',
                            color: AppColors.sendTextColor,
                            fontWeight: AppDim.weightBold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        )
    );
  }

  /// 인증번호 전송버튼 Indicator
  Widget buildSendMessageProgressIndicator() => Platform.isAndroid
      ? const SizedBox(
          height: 10.0,
          width: 10.0,
          child: CircularProgressIndicator(strokeWidth: 2),
        )
      : const SizedBox(
          height: 10,
          width: 10,
          child: CupertinoActivityIndicator(radius: 8),
        );
}
