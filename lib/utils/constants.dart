
class Constants {
  static const appName = 'GHealth';
  static const appVersion = '1.0.3';

  static List<String> generateTargetList(int start, int end, int step) {
    List<String> targetList = [];
    for (int i = start; i <= end; i += step) {
      targetList.add(i.toString());
    }
    return targetList;
  }

  static final targetStepsList = generateTargetList(1000, 60000, 1000);
  static final targetSleepList = generateTargetList(1, 10, 1);
}
