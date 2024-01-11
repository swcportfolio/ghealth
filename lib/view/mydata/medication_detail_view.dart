

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../widgets/frame.dart';
import 'medication_detail_viewmodel.dart';

enum MedicationInfoType{
  taking, // 복약
  usage, // 용법
  efficacy, // 효능
  advise, // 주의
  dur, // DUR
  basic, // 기본
}

class MedicationDetailView extends StatefulWidget {
  const MedicationDetailView({super.key, required this.medicationCode});

  /// 처방 약 코드
  final String medicationCode;

  @override
  State<MedicationDetailView> createState() => _MedicationDetailViewState();
}

class _MedicationDetailViewState extends State<MedicationDetailView> with TickerProviderStateMixin {

  final title = '처방 이력';
  late AnimationController animationController;
  late TabController _tabController;
  late MedicationDetailViewModel _viewModel;

  MedicationInfoType statusType = MedicationInfoType.taking;



  @override
  void initState() {
    _viewModel = MedicationDetailViewModel(widget.medicationCode);

    animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
        lowerBound: 0.0,
        upperBound: 1.0);

    _tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: CustomAppBar(
        title: title,
        isIconBtn: false,
      ),

      body: ChangeNotifierProvider<MedicationDetailViewModel>(
        create: (BuildContext context) => _viewModel,
        child: FutureBuilder(
          future: _viewModel.handleMedicationDetail(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

            if(snapshot.hasError){
              return Frame.buildFutureBuilderHasError(
                  snapshot.error.toString(), ()=> {}
              );
            }
            else if(snapshot.connectionState == ConnectionState.done
                && snapshot.data == null) {
              return Frame.buildCommonEmptyView('약 정보를 불러 오지 못했습니다.');
            }
            else if(snapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [

                      /// 처방 약 이미지
                      buildImage(),

                      /// 처방 약 정보
                      buildMedicineInfo(),
                      const Gap(15),

                      /// 처방 약 상세
                      buildMedicineDetail(),
                      const Gap(20)

                    ],
                  ),
                ),
              );
            } else {
              return Frame.buildFutureBuildProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget buildImage() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(width: 2.0, color: Colors.grey.shade200)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Frame.buildExtendedImage(
            animationController,
            '${_viewModel.medicationDetailData?.imageUrl}', double.infinity),
      )
    );
  }

  Widget buildMedicineInfo() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(width: 2.0, color: Colors.grey.shade200)),
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Frame.myText(
            text: '${_viewModel.medicationDetailData?.drugNameKR}',
            fontSize: 1.5,
            fontWeight: FontWeight.bold,
          ),
          const Gap(20.0),

          Frame.myText(
            text: '• ${_viewModel.medicationDetailData?.drugNameEN}',
            maxLinesCount: 3,
            softWrap: true
          ),
          const Gap(10.0),

          Frame.myText(
                text: '• ${_viewModel.medicationDetailData?.ingredient}',
                maxLinesCount: 3,
                softWrap: true),
            const Gap(10.0),

          Frame.myText(
            text: '• 보험급여가격: 0',
          )
        ],
      )
    );
  }

  Widget buildMedicineDetail() {
    return Consumer<MedicationDetailViewModel>(
      builder: (BuildContext context, value, Widget? child) {
        return Column(
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildChip('복약', MedicationInfoType.taking, value.isSelectedList[0]),
                  buildChip('용법', MedicationInfoType.usage, value.isSelectedList[1]),
                  buildChip('효능', MedicationInfoType.efficacy, value.isSelectedList[2]),
                  buildChip('주의', MedicationInfoType.advise,value.isSelectedList[3]),
                  buildChip('DUR', MedicationInfoType.dur, value.isSelectedList[4]),
                  buildChip('기본', MedicationInfoType.basic, value.isSelectedList[5]),
                ],
              ),
            ),

            value.isSelectedList[5]
                ? buildMedicationInfoBasicItem()
                : buildMedicineInfoDefaultItem(value.medicationEtcTitle, value.medicationEtcContent),
          ],
          //buildSelectedChipView()
        );
      },
    );
  }

  Widget buildMedicineInfoDefaultItem(String title, String content){
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color(0xfff4f4f4)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(color: Colors.grey.shade400, width: 1.5),
                  color: Colors.white
                ),
                child: Frame.myText(
                  text: title, //'',
                  fontWeight: FontWeight.w600
                ),
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Frame.myText(
                    text: content,
                    fontSize: 0.9,
                    softWrap: true,
                    maxLinesCount: 700
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  buildMedicationInfoBasicItem(){
    return Consumer<MedicationDetailViewModel>(
      builder: (BuildContext context, value, Widget? child) {
        return  Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: const Color(0xfff4f4f4)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(color: Colors.grey.shade400, width: 1.5),
                    color: Colors.white
                ),
                child: Frame.myText(
                    text: value.medicationEtcTitle,
                    fontWeight: FontWeight.w600
                ),
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Frame.myText(
                    text: value.medicationEtcContent,
                    fontSize: 0.9,
                    softWrap: true,
                    maxLinesCount: 700
                ),
              ),
              const Gap(20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(color: Colors.grey.shade400, width: 1.5),
                    color: Colors.white
                ),
                child: Frame.myText(
                    text: value.medicationIngredientTitle,
                    fontWeight: FontWeight.w600
                ),
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Frame.myText(
                    text: value.medicationIngredientContent,
                    fontSize: 0.9,
                    softWrap: true,
                    maxLinesCount: 700
                ),
              ),
              const Gap(20),


              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(color: Colors.grey.shade400, width: 1.5),
                    color: Colors.white
                ),
                child: Frame.myText(
                    text: value.medicationPropertiesTitle,
                    fontWeight: FontWeight.w600
                ),
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Frame.myText(
                    text: value.medicationPropertiesContent,
                    fontSize: 0.9,
                    softWrap: true,
                    maxLinesCount: 700
                ),
              ),
            ],
          ),
        );
      },
    );
  }



  Widget buildChip(String label, MedicationInfoType type, isSelected) {
    return  GestureDetector(
      onTap: ()=> _viewModel.onPressedChip(type),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Chip(
          labelPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
          backgroundColor: isSelected ? const Color(0xffe5ecff) : Colors.white,
          label: Frame.myText(
            text: label,
            fontSize: 0.9,
            color: isSelected ? mainColor : Colors.grey.shade600,
            fontWeight: FontWeight.w600
          ),
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected ? mainColor : Colors.grey.shade400,
              width: 1.5,
            ),
          ),
          padding: const EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}
