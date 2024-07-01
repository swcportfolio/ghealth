import 'package:hive/hive.dart';

part 'attendance_data.g.dart';

@HiveType(typeId: 0)
class AttendanceData extends HiveObject {
  @HiveField(0)
  DateTime date;

  AttendanceData({required this.date});
}