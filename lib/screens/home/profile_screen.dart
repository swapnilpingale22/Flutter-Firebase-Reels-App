import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fun_unlimited/services/auth_services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;

  final db = FirebaseFirestore.instance;

  final AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
            stream:
                db.collection('users').doc(_auth.currentUser!.uid).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.data() == null) {
                return const Center(child: Text('No data available'));
              }

              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 2,
                      offset: Offset(3, 3),
                      color: Colors.black38,
                    )
                  ],
                ),
                child: ListTile(
                  title: Text('${userData['name']}'),
                  subtitle: Text('${userData['email']}'),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 27,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black,
                      foregroundImage: NetworkImage(
                        "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=600",
                      ),
                    ),
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              await _authServices.signOut(context);
            },
            child: const Text('Sign Out'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              await _authServices.deleteAccount(context);
            },
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );
  }
}
