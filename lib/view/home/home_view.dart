import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gallery_3d/gallery3d.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/utils/etc.dart';
import 'package:ghealth_app/widgets/frame.dart';

import '../../data/models/gallery3d_data.dart';
import '../../utils/colors.dart';
import '../../widgets/list_item/service_list_item.dart';
import '../../widgets/menu_card.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  /// 서비스 라벨 리스트
  List<String> serviceLabel = ['헬스케어', '유전자 검사', '건강검진 기반\n 질환예측', '식습관 관리'];

  late List<Widget> menuList;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    menuList = [
      Gallery3DMenuCard(
        gallery3dData: Gallery3dData(
            '동구라이프로그 건강관리소',
            '헬스케어 장비를 활용한\n시만 맞춤형 건강케어 서비스',
            '서남동 행정복지센터2층(동구 서남로 14)',
            'card_image_1.jpg',
            280,
            Uri(
              scheme: 'https',
              host: 'lifelog.ghealth.or.kr',
              path: '',
            ),
            GalleryType.card1),
        mContext: context,
      ),
      Gallery3DMenuCard(
          gallery3dData: Gallery3dData(
              '광주광역시 스트레스 샤워실',
              '스트레스 관리, 평온한 쉼을\n제공하는 힐링 솔루션 서비스',
              '광주광역시청(서남구 내방로 111)',
              'card_image_2.jpg',
              240,
              Uri(
                scheme: 'https',
                host: 'www.ghealth.or.kr',
                path: '/reservation/ssroom/',
              ),
              GalleryType.card2),
          mContext: context),
      Gallery3DMenuCard(
          gallery3dData: Gallery3dData(
              'G-Health 기업 실증',
              '새로운 헬스케어 제품을\n체험해보는 사용성 테스트',
              '기업별 상이(선정인원 개별 안내)',
              'card_image_3.png',
              360,
              Uri(
                scheme: 'https',
                host: 'ecrf.ghealth.or.kr',
                path: '/pub/apply',
              ),
              GalleryType.card3),
          mContext: context),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 소개글
            buildWelComeText(),

            buildCarouselSlider(),
            ///buildGallery3D(),

            /// 방문 예약 내역
            ///buildVisitReservations(),

            /// 서비스 소개
            /// buildServiceIntroduction(),

            /// 참여자 리뷰 및 현장
            /// YoutubeVideoPlayer(),

            /// 서비스 지원 버튼
            buildSupportServiceBtn(),

            /// 협력사 이미지
            buildPOImage(),
          ],
        ),
      ),
    );
  }

  /// 인사말 Text, Image
  Widget buildWelComeText() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children:
            [
              // 메인 타이틀 Text
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Frame.myText(
                        text: 'GHealth',
                        fontWeight: FontWeight.w600,
                        fontSize: 2.1,
                        color: mainColor
                    ),
                    Frame.myText(
                        text: '건강관리 서비스란?',
                        fontWeight: FontWeight.w400,
                        fontSize: 2.0,
                        color: mainColor
                    ),
                  ],
                ),
              ),

              // 오른쪽 상단 최고 이미지
              Image.asset(
                  'images/best_image.png',
                  height: 100,
                  width: 100
              )

            ],
          ),

          // 서브 타이틀 Text
          SizedBox(
            width: 100,
            child: Frame.myText(
              text: '3개의 건강 주제와 헬스케어 장비를 중심으로\n시민 개인의 건강기록 통합 • 관리 및 전문인력이\n맞춤형 상담을 제공하는 서비스',
              maxLinesCount: 3,
              fontSize: 1.0
            ),
          )

        ],
      ),
    );
  }



Widget buildCarouselSlider(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: CarouselSlider.builder(
        itemCount: menuList.length,
        options: CarouselOptions(
          height: 360,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.zoom,

          viewportFraction: 0.75,
          enlargeFactor: 0.45, //좌우 item 크기
        ),
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
        menuList[itemIndex]
      ),
    );
}

/// Disabled widget
Widget buildGallery3D() {
  return Gallery3D(
      controller: Gallery3DController(itemCount: menuList.length, autoLoop: false, minScale: 0.7),
      width: MediaQuery.of(context).size.width,
      height: 500,
      isClip: true,
      // ellipseHeight: 80,
      // currentIndex: currentIndex,
      onItemChanged: (index) {
        // setState(() {
        //   currentIndex = index;
        // });
      },
      itemConfig: const GalleryItemConfig(
        width: 280,
        height: 350,
        radius: 20,
        isShowTransformMask: true,
        // shadows: [
        //   BoxShadow(
        //       color: Color(0x90000000), offset: Offset(2, 0), blurRadius: 5)
        // ]
      ),
      onClickItem: (index) {
         print("currentIndex:$index");
      },
      itemBuilder: (context, index) {
        return menuList[index];
      });
}

  /// 방문 예약 내역
  Widget buildVisitReservations(){
    return Container(
      height: 130,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: mainColor, width: 2)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Frame.myText(
                  text: '방문 예약 내역',
                  fontSize: 1.3,
                  fontWeight: FontWeight.bold,
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20,)
              ],
            ),
          ),
          const Gap(15),

          /// 방문예약이 있을 경우 Wiget
          /// buildReservationBtn()
          SizedBox(
            height: 60,
            child: Card(
              color: mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                  [
                    // 예약 날짜 Icon&Text
                    Row(
                      children: [
                        const Icon(Icons.calendar_month_outlined, color: Colors.white),
                        const Gap(8),
                        Frame.myText(
                          text: '2023.10.25.수',
                          color: Colors.white,
                          fontSize: 1.2,
                          fontWeight: FontWeight.w400,
                        )
                      ],
                    ),
                    Etc.buildVerticalDivider(Colors.white),

                    // 예약 시간 Icon&Text
                    Row(
                      children: [
                        const Icon(Icons.access_time, color: Colors.white),
                        const Gap(8),
                        Frame.myText(
                          text: '13:30',
                          color: Colors.white,
                          fontSize: 1.2,
                          fontWeight: FontWeight.w400,
                        )
                      ],
                    ),

                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }

  /// 서비스 소개 위젯
  Widget buildServiceIntroduction(){
    return Container(
      height: 210,
      width: double.infinity,
      margin: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          // 서비스 소개 타이틀
          Frame.myText(
            text: '서비스 소개',
            fontWeight: FontWeight.bold,
            fontSize: 1.4,
            color: Colors.black,
            align: TextAlign.start
          ),
          const Gap(15),

          // 서비스 소개 리스트(가로형) 뷰
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: serviceLabel.length,
              itemExtent: 115,
              itemBuilder: (BuildContext context, int index) {
                return ServiceListItem(label: serviceLabel[index], index: index);
              },
            ),
          )
        ],
      ),
    );
  }

  /// 지원 서비스 더 알아보기 버튼
  Widget buildSupportServiceBtn(){
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: mainColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Frame.myText(
          text: '지원 서비스 더 알아보기',
          fontSize: 1.3,
          fontWeight: FontWeight.w600,
          color: mainColor,
        ),
      ),
    );
  }

  /// PO: Participating organizations - 참여기관
  Widget buildPOImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Image.asset('images/organizations.png'),
    );
  }

  /// 방문 예약 내역이 없을 시 보여주는 버튼
  Widget buildReservationBtn(){
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Center(
        child: Frame.myText(
          text: '방문 예약하기',
          fontWeight: FontWeight.bold,
          fontSize: 1.4,
          color: Colors.white,
        ),
      )
    );
  }


}











