import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/utils/colors.dart';
import 'package:ghealth_app/widgets/frame.dart';
import 'package:ghealth_app/widgets/girdview/gridview_provider.dart';
import 'package:provider/provider.dart';

class SelectTimeGridview extends StatefulWidget {
  const SelectTimeGridview({
    super.key,
    required this.mWidth,
    required this.mHeight,
    required this.childAspectRatio
  });

  final double mWidth;
  final double mHeight;
  final double childAspectRatio;

  @override
  State<SelectTimeGridview> createState() => _SelectTimeGridviewState();
}

class _SelectTimeGridviewState extends State<SelectTimeGridview> {

  List<String> sampleTimeList = ['09:00','10:00','11:00','13:30','14:30','15:30','16:30'];
  List<bool> isSelected = List.filled(7, false);
  int? selectedIndex = 0;

  late ReservationTime _reservationTime;

  @override
  Widget build(BuildContext context) {
    _reservationTime = Provider.of<ReservationTime>(context, listen: false);

    return Container(
      height: 140,
      width: widget.mWidth,
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: GridView.builder(
        itemCount: sampleTimeList.length,
        scrollDirection: Axis.vertical,           //default
        reverse: false,                           //default
        controller: ScrollController(),
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(5.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: widget.childAspectRatio,
        ),
        semanticChildCount: 3,
        cacheExtent: 0.0,
        dragStartBehavior: DragStartBehavior.start,
        clipBehavior: Clip.hardEdge,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        itemBuilder: (BuildContext context, int index) {
          return _buildSortOption(sampleTimeList[index], isSelected[index], index);
        },
        // List of Widgets
      ),
    );
  }

  Widget _buildSortOption(String time, bool selected, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = List.filled(7, false); // Unselect all
          if(selected){
            isSelected[index] = false;
            selectedIndex == null;
          } else {
            isSelected[index] = true; // Select the tapped item
            selectedIndex = index;
            _reservationTime.setSelectTime = sampleTimeList[index];
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: selected ? mainColor : Colors.white,
          border: Border.all(
            color: selected ? mainColor : Colors.grey.shade400,
            width: 1.5,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: Frame.myText(
              text: time,
              fontSize: 1.0,
              fontWeight: FontWeight.w400,
              color: selected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
// gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3,
//             mainAxisSpacing: 10.0,
//             crossAxisSpacing: 10.0,
//             childAspectRatio:3.1
//         ),
//         semanticChildCount: 3,
//         cacheExtent: 0.0,