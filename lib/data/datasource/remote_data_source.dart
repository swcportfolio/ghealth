
/// 데이터를 가져오는 영역
class RemoteDataSource {
  // final _firebaseInstance = FirebaseFirestore.instance;

  // /// 앱 광고 알람 수신 업데이트
  // Future<void> updateAlarmAdvertisement(bool isAdvertisement) async {
  //   try {
  //     await _firebaseInstance
  //         .collection('users')
  //         .doc('${Authorization().uid}')
  //         .update({
  //           'isAdvertisement': isAdvertisement,
  //         }).timeout(Duration(seconds: 4));
  //
  //     mLog.i('Users AlarmAdvertisement updated!');
  //   } catch (error) {
  //     mLog.e("Failed to update users AlarmAdvertisement: $error");
  //     throw Exception(error);
  //   }
}

// Future<List<Post>> getPosts() async {
// const path = '/api/posts';
// const params = <String, String>{};
// const uri = Uri.https("flutter_sample.com", path, params);
// final res = await http.get(uri);
// if (res.statusCode == HttpStatus.ok) {
//   final data = _bytesToJson(res.bodyBytes) as List;
//   return data.map((el) => Post.fromMap(el as Map)).toList();
// } else {
//   throw Exception("Error on server");
// }
//}

// Stream<List<Todo>> getTodoListStream() {
//   return _firestore.collection('todos').snapshots().map((snapshot) {
//     return snapshot.docs.map((doc) {
//       final data = doc.data() as Map<String, dynamic>;
//       return Todo(
//         id: doc.id,
//         title: data['title'],
//         isDone: data['isDone'],
//       );
//     }).toList();
//   });
// }

