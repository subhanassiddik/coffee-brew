import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_brew/models/brew.dart';
import 'package:coffe_brew/models/user_data.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({ this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  // collection references
  Future updateUserData(String sugar, String name, int strength) async {
    return await brewCollection
        .doc(uid)
        .set({'sugars': sugar, 'name': name, 'strength': strength});
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Brew(
          name: doc.get('name') ?? '',
          strength: doc.get('strength') ?? 0,
          sugars: doc.get('sugars') ?? '0');
    }).toList();
  }

  // User data detail from snapshot
  UserDataDetail _userDataDetailFromSnapshot(DocumentSnapshot snapshot) {
    return UserDataDetail(
        name: snapshot.get('name'),
        strength: snapshot.get('strength'),
        sugars: snapshot.get('sugars'),
        uid: uid!);
  }

  //get brew stream
  Stream<List<Brew>?> get brews {
    return brewCollection.snapshots().map((_brewListFromSnapshot));
  }

  //get user doc stream
  Stream<UserDataDetail> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataDetailFromSnapshot);
  }
}
