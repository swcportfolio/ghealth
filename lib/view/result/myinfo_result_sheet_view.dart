
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/data/models/prescription_data.dart';
import 'package:ghealth_app/view/point/point_management_view.dart';
import 'package:ghealth_app/view/result/examination_record_view.dart';
import 'package:ghealth_app/widgets/frame.dart';

import '../../utils/colors.dart';
import '../../widgets/horizontal_dashed_line.dart';
import '../../widgets/my_richtext.dart';

/// 나의 건강정보 종합 결과지
class MyInfoResultSheetView extends StatefulWidget {
  const MyInfoResultSheetView({super.key});

  @override
  State<MyInfoResultSheetView> createState() => _MyInfoResultSheetViewState();
}

class _MyInfoResultSheetViewState extends State<MyInfoResultSheetView> {

  /// 디바이스 사이즈
  late Size deviceSize;

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              /// 페이지 안내 메시지 Top
              buildFinalResult(),
              const Gap(15),

              /// 건강 포인트
              buildHealthPointBox(),
              const Gap(15),

              /// 건강검진 결과 안내 Box
              buildHealthCheckupResult(),
              const Gap(15),

              /// 혈액 검사 결과 Box
              buildBloodTest(),
              const Gap(15),

              /// 계측 검사
              buildMetrologyInspection(),
              const Gap(15),

              /// AI 질환 예측 결과
              buildAiDiseasePredictionResults(),
              const Gap(15),

              /// 처방 이력
              buildPrescriptionHistory(),
              const Gap(15),


            ],
          ),
        )
      ),
    );
  }

  Widget buildFinalResult(){
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Frame.myText(
                text: '안녕하세요. 홍길동님!',
                fontSize: 1.2,
                fontWeight: FontWeight.w500,
              ),
              const Gap(5),
              Frame.myText(
                text:'걷기 좋은 가을날,\n가벼운 산책 어떠세요?',
                maxLinesCount: 2,
                color: mainColor,
                fontWeight: FontWeight.w600,
                fontSize: 1.9
              )
            ],
          )
        ]
      ),
    );
  }

  Widget buildHealthPointBox() {
   return InkWell(
     onTap: ()=> Frame.doPagePush(context, const PointManagementView()),
     child: Card(
       elevation: 3,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(20.0),
       ),
       child: SizedBox(
         width: double.infinity,
         height: 130,
         child: Column(
           children: [
             Container(
               height: 50,
               padding: const EdgeInsets.fromLTRB(25, 15, 10, 15),
               decoration: const BoxDecoration(
                 color: mainColor,
                 borderRadius: BorderRadius.only(
                   topLeft: Radius.circular(20.0),
                   topRight: Radius.circular(20.0),
                 ),
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Frame.myText(
                     text: '건강포인트',
                     color: Colors.white,
                     fontSize: 1.2,
                     fontWeight: FontWeight.w600
                   ),
                   // arrow 아이콘
                   const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20,)
                 ],
               ),
             ),


             /// 포인트 이미지, 포인트 점수
             Container(
               height: 80,
               padding: const EdgeInsets.symmetric(horizontal: 20),
               decoration: const BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.only(
                   bottomRight: Radius.circular(20.0),
                   bottomLeft: Radius.circular(20.0),
                 ),
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(2.0),
                     child: Image.asset('images/point.png', color: mainColor, height: 40, width: 40),
                   ),
                   const Gap(5),

                   Frame.myText(
                     text: '11,000',
                     fontSize: 2.2,
                     fontWeight: FontWeight.w400,
                     color: Colors.black,
                   ),
                   const Gap(10),


                   Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: [
                       Frame.myText(
                           text:'나의 건강 포인트 확인하고'
                       ),
                       Frame.myText(
                           text:'저렴하게 진료받으세요!',
                         fontWeight: FontWeight.w600
                       ),
                     ],
                   )
                 ],
               ),
             ),
           ]
         )
       ),
     ),
   );
  }

  Widget buildHealthCheckupResult() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.greenAccent, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Frame.myText(
                    text: '건강 검진 결과 안내',
                    color: Colors.black,
                    fontSize: 1.2,
                    fontWeight: FontWeight.w600
                ),
                // arrow 아이콘
                const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20)
              ],
            ),

            Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.green,
              ),
              child: Center(
                child: Frame.myText(
                  text: '정상B(경계) 판정',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 1.5
                ),
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: Frame.myText(
                  text: '• 일주일에 2일 이상 신체 각 부위를 모두 포함하여 근력운동을 수행하십시오.',
                  maxLinesCount: 2,
                  fontSize: 1.1,
                  softWrap: true
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 계측 검사, 사람 모양
  Widget buildMetrologyInspection() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 610,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(30.0)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// 검진 날짜 Text
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Frame.myText(
                      text: '계측 검사',
                      color: Colors.black,
                      fontSize: 1.2,
                      fontWeight: FontWeight.w600
                  ),

                  /// 검진 날짜
                  Frame.myText(
                    text: '검진일 : 2023-10-00',
                    fontSize: 0.9,
                  )
                ],
              ),

              /// 사람 이미지
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('images/body_image.png', height: 460, width: 180,),
              ),
              const Gap(15),


              Frame.myText(
                  text: '클릭하시면 자세한 결과를 보실수 있습니다.',
                  color: Colors.grey.shade600,
                  fontSize: 1.1
              ),
            ],
          ),
        ),

        /// 각 항목 Positioned Container
        buildMeasurementResultPositionedItem(40, 80, null, null, '0.8 / 0.7', '시력(좌/우)'),
        buildMeasurementResultPositionedItem(20, 200, null, null, '120/61', '혈압'),
        buildMeasurementResultPositionedItem(30, 360, null, null, '46.8', '몸무게'),
        buildMeasurementResultPositionedItem(35, 460, null, null, '154.8', '키'),
        buildMeasurementResultPositionedItem(null, 83, 50, null, '정상/정상', '청력(좌/우)'),
        buildMeasurementResultPositionedItem(null, 205, 40, null, '69', '허리둘레'),
        buildMeasurementResultPositionedItem(null, 335, 25, null, '19.5', '체질량지수'),
      ],
    );
  }
  /// Prescription sample data list
  List<PrescriptionData> prescriptionDataList = [
    PrescriptionData(imagePath: 'images/medicine_image_1.png', dateOfManufacture: '20230607', productName: '티지피시메티딘정(0.2g/1정'),
    PrescriptionData(imagePath: 'images/medicine_image_2.png', dateOfManufacture: '20230607', productName: '티지피시메티딘정(0.2g/1정'),
  ];

  /// 처방 이력
  Widget buildPrescriptionHistory(){
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
                  itemCount: prescriptionDataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PrescriptionListItem(prescriptionData: prescriptionDataList[index]);
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




  /// 계측검사 검사 결과 Positioned item
  Widget buildMeasurementResultPositionedItem(
      double? left,
      double? top,
      double? right,
      double? bottom,
      String resultText,
      String resultLabel
      ){
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Column(
        children: [
          /// 검사 결과 박스
          Container(
            height: 35,
            width: 80,
            decoration: BoxDecoration(
                color: metrologyInspectionBgColor,
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(width: 1, color: Colors.blueAccent)),
            child: Center(
              child: Frame.myText(
                  text: resultText,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
          ),
          const Gap(5),

          /// 측정 항목명 텍스트
          Frame.myText(text: resultLabel, fontSize: 1.0)
        ],
      ),
    );
  }

  /// 혈액 검사 결과 위젯
  Widget buildBloodTest(){
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 320,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          color: bloodResultBgColor,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.redAccent.shade200, width: 2),

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Frame.myText(
                    text: '혈액 검사',
                    color: Colors.black,
                    fontSize: 1.2,
                    fontWeight: FontWeight.w600
                ),

                /// 검진 날짜
                Frame.myText(
                  text: '검진일 : 2023-10-00',
                  fontSize: 0.9,
                )
              ],
            ),

            SizedBox(
              height: 220,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return const BloodResultItem();
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: Frame.myText(
                  text: '• 총콜레스테롤 수치에 대한 관리가 필요합니다.',
                  maxLinesCount: 2,
                  fontSize: 1.0,
                  softWrap: true
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// AI 질환 예측 결과 위젯
  Widget buildAiDiseasePredictionResults(){
    return Card(
      color: Colors.grey.shade100,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 170,
        width: double.infinity,
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Frame.myText(
              text: 'AI 질환 예측 결과',
              fontSize: 1.3,
              fontWeight: FontWeight.w600
            ),
            const Gap(5),

            Frame.myText(
                text: '유전체+건강검진이력+라이프로그 데이터를\n결합한 예측결과로 주의를 받은 항목입니다.',
                maxLinesCount: 2,
                fontSize: 1.0,
            ),
            const Gap(15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 40,
                  width: 90,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.redAccent, width: 1)
                  ),
                  child: Center(
                    child: Frame.myText(
                      text: '고혈압',
                      fontSize: 1.1,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 90,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.redAccent, width: 1)
                  ),
                  child: Center(
                    child: Frame.myText(
                      text: '당뇨',
                      fontSize: 1.1,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 100,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.redAccent, width: 1)
                  ),
                  child: Center(
                    child: Frame.myText(
                      text: '대사증후군',
                      fontSize: 1.1,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


/// 혈액 검사 결과 아이템
class BloodResultItem extends StatelessWidget {
  const BloodResultItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.fromLTRB(20, 10, 5, 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade400, width: 1.5)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Frame.myText(
            text: '혈색소',
            fontSize: 1.2,
          ),

          Row(
            children: [
              const Icon(Icons.arrow_drop_up_outlined, color: Colors.green),
              Frame.myText(
                text:'13.2',
                fontWeight: FontWeight.w600,
                fontSize: 1.4,
              ),
              Frame.myText(
                text:'g/dL',
                fontWeight: FontWeight.normal,
                fontSize: 1.3,
              ),
              const Gap(5),

              Image.asset('images/blood_arrow_icon.png', height: 50, width: 50)
            ],
          )
        ],
      ),
    );
  }
}

/// 약처방 내역 리스트 아이템
class PrescriptionListItem extends StatelessWidget {
  const PrescriptionListItem({super.key, required this.prescriptionData});
  final PrescriptionData prescriptionData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(prescriptionData.imagePath, height: 70, width: 70),
          const Gap(15),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Frame.myText(
                text: '조제일자  ${prescriptionData.dateOfManufacture}'
              ),
              const Gap(3),
              Frame.myText(
                  text: '제 품 명  ${prescriptionData.productName}'
              )
            ],
          )

        ],
      ),
    );
  }
}


