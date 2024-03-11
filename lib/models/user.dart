import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String email;
  final int mobileNumber;
  final String uid;

  const User({
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'mobileNumber': mobileNumber,
        'uid': uid,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      name: snapshot['name'],
      email: snapshot['email'],
      mobileNumber: snapshot['mobileNumber'],
      uid: snapshot['uid'],
    );
  }
}
