import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_and_firebase/models/brew.dart';
import 'package:flutter_and_firebase/models/member.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars,String name,int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars' : sugars,
      'name' : name,
      'strength' : strength
    });
  }

  // brew list form snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc.data()['name'] ?? '',
        strength: doc.data()['strength'] ?? 0,
        sugar: doc.data()['sugars'] ?? '0',
      );
    }).toList();
  }

  // userData form snapshot
  MemberData _userDataFormSnapshot(DocumentSnapshot snapshot) {
    return MemberData(
      uid: uid,
      name: snapshot.data()['name'],
      sugars: snapshot.data()['sugars'],
      strength: snapshot.data()['strength'],
    );
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
    .map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<MemberData> get userData {
    return brewCollection.doc(uid).snapshots()
        .map(_userDataFormSnapshot);
  }
}