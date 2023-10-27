import 'package:flutter/material.dart';
import 'package:flutter_gallery_3d/gallery3d.dart';
import 'package:ghealth_app/widgets/frame.dart';
import 'package:ghealth_app/widgets/menu_card.dart';

import '../../utlis/colors.dart';
import '../../widgets/custom_appbar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  List<Widget> menuList = [
    const MenuCard1(),
    const MenuCard2(),
    const MenuCard3(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            buildWelComeText(),
            const SizedBox(height: 0),
            //buildMenuScaledList(),
            buildGallery3D(),
            buildPOImage(),

            /// 임시
            const SizedBox(height: 20),
            Image.asset('images/ex_main_ghealth.png')
          ],
        ),
      ),
    );
  }

  Widget buildWelComeText() {
    return Container(
      height: 100,
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Frame.myText(
              text: '홍길동님',
              fontWeight: FontWeight.w600,
              fontSize: 2.4,
              color: Colors.black
          ),
          Row(
            children: [
              Frame.myText(
                  text: '오늘도 ',
                  fontWeight: FontWeight.w600,
                  fontSize: 1.4,
                  color: Colors.black
              ),
              Frame.myText(
                  text: '촉촉한 하루',
                  fontWeight: FontWeight.w500,
                  fontSize: 1.4,
                  color: mainColor
              ),
              Frame.myText(
                  text: '되세요!',
                  fontWeight: FontWeight.w500,
                  fontSize: 1.4,
                  color: Colors.black
              ),
            ],
          )
        ],
      ),
    );
  }


  Widget buildGallery3D() {
    return Gallery3D(
        controller: Gallery3DController(itemCount: menuList.length, autoLoop: false, minScale: 0.7),
        width: MediaQuery.of(context).size.width,
        height: 360,
        isClip: false,
        // ellipseHeight: 80,
        // currentIndex: currentIndex,
        onItemChanged: (index) {
          // setState(() {
          //   currentIndex = index;
          // });
        },
        itemConfig: const GalleryItemConfig(
          width: 280,
          height: 320,
          radius: 20,
          isShowTransformMask: true,
          // shadows: [
          //   BoxShadow(
          //       color: Color(0x90000000), offset: Offset(2, 0), blurRadius: 5)
          // ]
        ),
        // onClickItem: (index) {
        //   if (kDebugMode) print("currentIndex:$index");
        // },
        itemBuilder: (context, index) {
          return menuList[index];
        });
  }

  ///PO: Participating organizations- 참여기관
  Widget buildPOImage(){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Image.asset('images/organizations.png'),
      );
  }
}



