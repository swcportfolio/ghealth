import 'package:flutter/material.dart';
import 'package:ghealth_app/view/reservation/reservation_view.dart';
import 'package:ghealth_app/widgets/frame.dart';
import 'package:ghealth_app/widgets/horizontal_dashed_line.dart';

import '../../utlis/colors.dart';

List<Reservation> reservationList = [ ];

class Reservation {
  late String userID;
  late String date;
  late String time;

  Reservation({required this.userID, required this.date, required this.time});
}

/// 예약 내역 화면
class ReservationHistoryView extends StatefulWidget {
  const ReservationHistoryView({super.key});

  @override
  State<ReservationHistoryView> createState() => _ReservationHistoryViewState();
}

class _ReservationHistoryViewState extends State<ReservationHistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        child: reservationList.isEmpty
            ? buildEmptyReservation()
            : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,10,15, 70),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: reservationList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ReservedCardItem(reservationInfo: reservationList[index]);
                      },
                    ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: buildReservationBtn(),
                )
              ],
            ),
      ),
    );
  }

  /// 예약 내역이 없을 시 보여주는 화면
  Widget buildEmptyReservation() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/reservation_empty.png', height: 120, width: 120, color: mainColor),
          const SizedBox(height: 10),
          Frame.myText(
            text: '현재 예약하신 내역이 없습니다.',
              fontWeight: FontWeight.bold,
              fontSize: 1.5,
          ),
          const SizedBox(height: 15),

          Frame.myText(
            text: '아직 대기 중인 예약이 없습니다. 새로운 예약을\n 만들려면 아래 버튼을 누르세요.',
            align: TextAlign.center,
            maxLinesCount: 2,
            fontSize: 1.1,
          ),
          const SizedBox(height: 20),

          GestureDetector(
            onTap: ()=> {
                //Navigator.of(context, )
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ReservationView())).then((_){
                  setState(() {});
                })
           },
            child: Container(
              height: 40,
              width: 130,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: mainColor,
                  width: 1.5,
                  style: BorderStyle.solid,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Frame.myText(
                      text:'예약하기',
                      fontSize: 1.2,
                      color: Colors.white
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.arrow_forward, color: Colors.white, size: 20,)
                  ],
                ),
              )
            ),
          )
        ],
      ),
    );
  }

  /// 방문 예약 버튼
  Widget buildReservationBtn(){
    return GestureDetector(
      onTap: ()=>{
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ReservationView())).then((_){
          setState(() {});
        })
      },
      child: Container(
        height: 55,
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        decoration: const BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        child: Center(
          child: Frame.myText(
            text: '방문 예약하기',
            fontSize: 1.4,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}

/// 예약내역 리스트 아이템
class ReservedCardItem extends StatelessWidget {
  const ReservedCardItem({super.key, required this.reservationInfo});
  final Reservation reservationInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: const EdgeInsets.only(bottom: 15),
      child: Card(
        color: reservedCardBgColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20 , 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //예약 날짜
                    Frame.myText(
                      text: '• ${reservationInfo.date}',
                      fontWeight: FontWeight.w500,
                      fontSize: 1.8,
                      color: Colors.black,
                    ),

                    //예약 시간
                    Frame.myText(
                      text: reservationInfo.time,
                      fontWeight: FontWeight.w500,
                      fontSize: 1.8,
                      color: Colors.black,
                    )
                  ],
                ),
              ),

              const HorizontalDottedLine(mWidth: double.infinity),

              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    reservationStatusBtn('예약 변경', Colors.white),
                    const SizedBox(width: 20),
                    reservationStatusBtn('예약 취소', const Color(0xFFececec)),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
  Widget reservationStatusBtn(String text, Color bgColor){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all( width: 1.5, color: Colors.grey)

      ),
      child: Frame.myText(
        text: text,
        fontSize: 1.1,
        color: Colors.grey.shade700
      ),
    );
  }

}

