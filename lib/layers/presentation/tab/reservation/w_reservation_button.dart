import 'package:flutter/material.dart';
import 'package:ghealth_app/layers/presentation/tab/reservation/vm_reservation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../common/common.dart';
import '../../widgets/style_text.dart';
import 'd_reservation.dart';

class ReservationButton extends StatelessWidget {
  const ReservationButton({super.key});

  String get btnLable => '예약하기';

  @override
  Widget build(BuildContext context) {
    return Consumer<ReservationViewModelTest>(
      builder: (context, provider, child) {
        return Visibility(
          visible: provider.isVisibleReservationBtn,
          child: InkWell(
            onTap: () =>
            {
              ReservationDialogTest.showReservationDialog(
                  width: MediaQuery.of(context).size.width,
                  mainContext: context,
                  reservationDate: DateFormat('yyyy-MM-dd').format(provider.selectedDay),
                  reservationTime: provider.selectedTime!,
                  saveReservationFunction: () => provider.handleSaveReservation(),
                  type: provider.currentRegionType,
              )
            },
            child: Container(
              height: AppConstants.buttonHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                  color:  AppColors.primaryColor,
                  borderRadius: BorderRadius.all(AppConstants.radius)
              ),
              child:  Center(
                child: StyleText(
                  text: btnLable,
                  size: AppDim.fontSizeLarge,
                  fontWeight: AppDim.weightBold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
