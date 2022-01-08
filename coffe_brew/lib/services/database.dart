import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_brew/models/brew.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

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
    return snapshot.docs .map((doc) {
      //print(doc.data);
      return Brew(
          name: doc.get('name')??'',
          strength: doc.get('strength') ?? 0,
          sugars: doc.get('sugars') ?? '0');
    }).toList();
  }

  //get brew stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map((_brewListFromSnapshot));
  }
}
