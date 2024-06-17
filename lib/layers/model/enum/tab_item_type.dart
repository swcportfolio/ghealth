import '../../../common/common.dart';

enum TabItemType {
  home('${AppStrings.imagePath}/tab/home/home.png', '홈\n', 0),
  checkup('${AppStrings.imagePath}/tab/reservation/reservation.png', '예약\n', 1),
  daily('${AppStrings.imagePath}/tab/aihealth/aihealth.png', 'AI\n건강예측', 2),
  aihealth('${AppStrings.imagePath}/tab/checkup/checkup.png', '나의\n건강검진', 3),
  urine('${AppStrings.imagePath}/tab/daily/daily.png', '나의\n일상기록', 4);

  const TabItemType(this.iconPath, this.label, this.itemIndex);
  final String iconPath;
  final String label;
  final int itemIndex;
}