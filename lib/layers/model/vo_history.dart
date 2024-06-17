class History {
  final int page;
  final String searchStartDate;
  final String searchEndDate;

  History({
    required this.page,
    required this.searchStartDate,
    required this.searchEndDate,
  });

  Map<String, dynamic> toMap(){
    return {
      'userID': 'sim3383', //TODO 임시
      'page': page,
      'searchStartDate': searchStartDate,
      'searchEndDate': searchEndDate,
    };
  }
}
