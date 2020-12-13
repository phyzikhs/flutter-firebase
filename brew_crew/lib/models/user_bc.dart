import 'package:cloud_firestore/cloud_firestore.dart';

class UserBC {
  final String uid;
  UserBC({this.uid});
}

class UserBCData {
  final String uid, name, sugars;
  final int strength;

  UserBCData({this.uid, this.name, this.sugars, this.strength});
}
