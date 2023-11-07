import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/utils/etc.dart';
import 'package:ghealth_app/widgets/frame.dart';

import '../data/models/gallery3d_data.dart';
import '../main.dart';
import '../utils/colors.dart';
import 'dialog.dart';

class Gallery3DMenuCard extends StatelessWidget {
  const Gallery3DMenuCard({super.key, required this.gallery3dData, required this.mContext});
  final Gallery3dData gallery3dData;
  final BuildContext mContext;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: mainColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// 타이틀
                GestureDetector(
                  onTap: ()=> {mLog.i('클릭중..')},
                  child: Frame.myText(
                    text: gallery3dData.title,
                    fontSize: 1.3,
                    maxLinesCount: 2,
                    color: Colors.white,
                    align: TextAlign.left,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                InkWell(
                    onTap: ()=> {
                      CustomDialog.showGallery3dDialog(mainContext: context, mHeight: gallery3dData.dialogHeight, type: gallery3dData.galleryType)
                    },
                    child: const Icon(Icons.info, color: Colors.white))
              ],
            ),
            const Gap(15),

            /// 서브 타이틀
            Frame.myText(
              text: gallery3dData.subTitle,
              fontSize: 1.0,
              maxLinesCount: 2,
              color: Colors.white,
              align: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
            Etc.solidLine(context),

             Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, color: Colors.white, size: 16,),
                const Gap(5),

                /// 주소
                Frame.myText(
                  text: gallery3dData.address,
                  fontSize: 0.9,
                  maxLinesCount: 2,
                  color: Colors.white,
                  align: TextAlign.center,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),

            /// 상세 이미지
            Container(
                height: 140,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 5),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset('images/${gallery3dData.imagePath}', fit: BoxFit.fill))
            ),

            /// 신청하기 버튼
            Container(
              width: 170,
              height: 40,
              margin: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child:  Center(
                child: Frame.myText(
                  text: '신청하기',
                  fontSize: 1.0,
                  color: mainColor,
                  align: TextAlign.center,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}

class MenuCard2 extends StatelessWidget {
  const MenuCard2({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 200,
      child: Card(
        color: mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Frame.myText(
                text: '방문 예약하기\n예약내역',
                fontSize: 1.9,
                maxLinesCount: 2,
                color: Colors.white,
                align: TextAlign.left,
                fontWeight: FontWeight.w600,
              ),
              const Gap(15),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('images/hospital_white.png', height: 100, width: 100),
                ],
              ),
              const Gap(10),

              Container(
                height: 90,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Frame.myText(
                          text: '지난 방문 내역',
                          color: Colors.black,
                          fontSize: 0.9
                        ),
                        const Gap(20),
                        Frame.myText(
                            text: '2023-09-09',
                            color: Colors.black,
                            fontSize: 1.1
                        ),
                      ],
                    ),
                    const Gap(10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Frame.myText(
                            text: '방문 예약 내역',
                            color: Colors.black,
                            fontSize: 0.9
                        ),
                        const Gap(20),
                        Frame.myText(
                            text: '2023-10-09',
                            color: Colors.black,
                            fontSize: 1.1
                        ),
                      ],
                    )
                  ],

                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

class MenuCard3 extends StatelessWidget {
  const MenuCard3({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 200,
      child: Card(
        color: mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Frame.myText(
                text: '식습관 관리\n서비스',
                maxLinesCount: 2,
                color: Colors.white,
                fontSize: 1.9,
                fontWeight: FontWeight.w600,
              )
            ],
          ),
        ),
      ),
    );
  }
}
