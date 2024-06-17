import 'package:ghealth_app/common/data/preference/item/nullable_preference_item.dart';
import 'package:ghealth_app/common/theme/custom_theme.dart';

import 'item/preference_item.dart';

class Prefs {
  static final appTheme = NullablePreferenceItem<CustomTheme>('appTheme');

  static final userID = PreferenceItem<String>('userID', '');
  static final userName = PreferenceItem<String>('userName', '');
  static final token = PreferenceItem<String>('token', '');
  static final gender = PreferenceItem<String>('gender', '');
  static final userIDOfD = PreferenceItem<String>('userIDOfD', '');
  static final userIDOfG = PreferenceItem<String>('userIDOfG', '');

  static final targetStep = PreferenceItem<String>('targetStep', '0');
  static final targetSleep = PreferenceItem<String>('targetSleep', '0');
  static final isToDayAttendance = PreferenceItem<bool>('isToDayAttendance', false);
  static final permissionDenied = PreferenceItem<bool>('permissionDenied', false);
  static final isCompletedPermission = PreferenceItem<bool>('isCompletedPermission', false);
}
