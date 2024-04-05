
// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/view/mydata/medication_info_detail_view.dart';

import '../../data/models/medication_Info_data.dart';
import '../../widgets/frame.dart';
import '../../widgets/horizontal_dashed_line.dart';
import '../../widgets/list_item/prescription_list_item.dart';

/// 처방 이력 - 투약정보 위젯
class PrescriptionHistoryWidget extends StatelessWidget {
  const PrescriptionHistoryWidget({super.key, required this.medicationInfoList});

  final  List<MedicationInfoData>? medicationInfoList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Card(
        color: Colors.grey.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SizedBox(
          height: medicationInfoList == null || medicationInfoList?.length == 0
              ? 220 : 300,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Frame.myText(
                        text: '처방이력',
                        fontSize: 1.2,
                        fontWeight: FontWeight.w600
                    ),

                    /// 더보기 버튼
                    Visibility(
                      visible: medicationInfoList == null || medicationInfoList?.length == 0
                          ? false : true,
                      child: InkWell(
                        onTap: ()=> Frame.doPagePush(context, const MedicationInfoDetailView()),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Frame.myText(
                                text: '자세히',
                                maxLinesCount: 2,
                                fontSize: 0.9,
                                fontWeight: FontWeight.w500,
                                softWrap: true),
                            const Gap(5),
                            const Padding(
                              padding: EdgeInsets.only(top: 1),
                              child: Icon(Icons.arrow_forward_ios, size: 12),
                            )
                          ],
                        ),
                      ),

                    )
                  ],
                ),
                const Gap(20),
                medicationInfoList == null || medicationInfoList?.length == 0
                    ? _buildMedicEmptyView()
                    : Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: medicationInfoList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PrescriptionListItem(
                                medicationInfoData: medicationInfoList![index]);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const HorizontalDottedLine(mWidth: 200);
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 건강 검진 결과 안내의 종합소견_판정의 데이터가 ''일 경우
  /// 전체 EmptyView 화면을 보여준다.
  _buildMedicEmptyView(){
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/empty_search_image.png', height: 60, width: 60),
          const Gap(15),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10.0)
            ),
            child: Frame.myText(
                text: '처방하신 내역이 없습니다.',
                maxLinesCount: 2,
                softWrap: true,
                fontSize: 1.0,
                fontWeight: FontWeight.w500
            ),
          )
        ],
      ),
    );
  }
}
