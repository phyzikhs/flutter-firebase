import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // collection reference
  // Firestore is deprecated. Instead, use FirebaseFirestore
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');
}
