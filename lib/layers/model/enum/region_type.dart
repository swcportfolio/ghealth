enum RegionType {
  gwangsangu('G','광산구'),
  donggu('D', '동구');

  const RegionType(this.label, this.name);

  final String label;
  final String name;
}