
enum MyDataMeasurementType {
  vision('시력'),
  bloodPressure('혈압'),
  weight('몸무게'),
  height('키'),
  hearingAbility('청력'),
  waistCircumference('허리둘레'),
  bodyMassIndex('체질량지수');

  const MyDataMeasurementType(this.label);

  final String label;

  static MyDataMeasurementType strToEnum(String str) {
    return MyDataMeasurementType.values.firstWhere((e) => e.label == str);
  }
}