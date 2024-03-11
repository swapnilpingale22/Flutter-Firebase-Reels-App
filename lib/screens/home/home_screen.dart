import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fun_unlimited/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  bool isLoading = false;
  var userData = {};

  @override
  void initState() {
    super.initState();
    // getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();

      userData = userSnap.data()!;

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        showSnackBar(e.toString(), context);
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userStream =
        db.collection('users').doc(_auth.currentUser!.uid).snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_library_rounded),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: userStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          var data = snapshot.data!.data() as Map<String, dynamic>;
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
              title: Text('${data['name']}'),
              subtitle: Text('${data['email']}'),
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
          //  ListTile(
          //   title: Text(data['name']),
          //   subtitle: Text(data['email']),
          // );
        },
      ),
    );
  }
}
