
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../data/models/medication_Info_data.dart';
import '../../widgets/frame.dart';
import '../../widgets/horizontal_dashed_line.dart';
import '../../widgets/list_item/prescription_list_item.dart';

class PrescriptionHistoryWidget extends StatelessWidget {
  const PrescriptionHistoryWidget({super.key, required this.medicationInfoList});

  final  List<MedicationInfoData> medicationInfoList;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SizedBox(
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Frame.myText(
                      text: '처방이력',
                      color: Colors.black,
                      fontSize: 1.2,
                      fontWeight: FontWeight.w600
                  ),
                  // arrow 아이콘
                  const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20)
                ],
              ),
              const Gap(20),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: medicationInfoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PrescriptionListItem(medicationInfoData: medicationInfoList[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const HorizontalDottedLine(mWidth: 200);
                  } ,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
