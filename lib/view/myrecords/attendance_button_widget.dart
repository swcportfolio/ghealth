

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:ghealth_app/utils/etc.dart';
import 'package:ghealth_app/view/myrecords/myrecord_main_viewmodel.dart';
import 'package:ghealth_app/widgets/frame.dart';

import '../../data/enum/snackbar_status_type.dart';
import '../../utils/colors.dart';
import '../../utils/snackbar_utils.dart';

/// 출석 체크 버튼
class AttendanceButtonWidget extends StatelessWidget {
  const AttendanceButtonWidget({super.key, required this.viewModel, required this.isAttendance});

  final MyRecordMainViewModel viewModel;
  final bool isAttendance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Card(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          width: double.infinity,
          height: 85,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                  width: 2,
                  color: isAttendance
                      ? Colors.grey.shade400
                      : mainColor)),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('images/attendance_image.png',
                          height: 45, width: 45),
                    ),
                    const Gap(10),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Frame.myText(
                          text: isAttendance? '출석완료!' : '출석하기',
                          fontWeight: FontWeight.bold,
                          fontSize: 1.2,
                        ),
                        const Gap(5),

                        Frame.myText(
                          text: '건강포인트 50P 지급',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              TextButton(
                onPressed: () => {
                  if (!isAttendance){
                      viewModel.handleAttendance()
                  } else {
                      SnackBarUtils.showStatusSnackBar(
                          message: '금일 출석을 완료하셨습니다.',
                          context: context,
                          statusType: SnackBarStatusType.success)
                    }
                },
                style: TextButton.styleFrom(
                  backgroundColor: isAttendance ? Colors.grey.shade300 : mainColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                ),
                child: Frame.myText(
                  text: '출석',
                  fontSize: 1.2,
                  fontWeight: FontWeight.bold,
                  color: isAttendance ? Colors.grey : Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
