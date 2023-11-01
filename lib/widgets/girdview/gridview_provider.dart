
import 'package:flutter/cupertino.dart';

class ReservationTime extends ChangeNotifier {
  late String? _selectTime;

  set setSelectTime(String value) {
    _selectTime = value;
    notifyListeners();
  }

  String? get selectTime => _selectTime;
}