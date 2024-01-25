import 'package:flutter/cupertino.dart';

/// picker data class
class PickerData{
  dynamic indexInitialValue;       // 초기 값(위치)
  List<dynamic> itemList;          // inout Type: [int or String]
  BuildContext context;            // Widget position
  Function(dynamic data) callback; // callback 함수 - picker 에서 선택된 데이터가 콜백 된다.

  PickerData(this.indexInitialValue, this.itemList, this.context, this.callback);

}