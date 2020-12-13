import 'package:brew_crew/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  // Firestore is deprecated. Instead, use FirebaseFirestore
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    // .document(...) is deprecated, instead use .doc(...)
    // .setData(...) is deprecated, instead use .set(...)
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Brew(
            name: doc.data()['name'] ?? '',
            strength: doc.data()['strength'] ?? 0,
            sugars: doc.data()['sugars'] ?? '0'))
        .toList();
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }
}
