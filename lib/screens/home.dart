import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tutroial/models/user.dart';
import 'package:firebase_tutroial/services/firebase_helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseHelper.buildViews,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            final List<UserModel> users = [];
            final List<QueryDocumentSnapshot>? docs = snapshot.data?.docs;
            if (docs == null || docs.isEmpty) {
              return const Text('No data');
            }

            for (var doc in docs) {
              if (doc.data() != null) {
                users.add(
                  UserModel.fromJson(doc.data() as Map<String, dynamic>),
                );
              }
            }

            return Column(
              children: users.map((e) => Text('Name is ${e.name}')).toList(),
            );
          },
        ),
      ),
    );
  }
}
