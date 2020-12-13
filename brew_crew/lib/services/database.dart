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

  // get brews stream
  Stream<QuerySnapshot> get brews {
    return brewCollection.snapshots();
  }
}
