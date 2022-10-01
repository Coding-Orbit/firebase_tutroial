import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tutroial/models/user.dart';
import 'package:firebase_tutroial/screens/send_notification_screen.dart';
import 'package:firebase_tutroial/services/firebase_helper.dart';
import 'package:firebase_tutroial/widgets/user_widget.dart';
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
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final List<UserModel> models = [];
            final List<QueryDocumentSnapshot>? docs = snapshot.data?.docs;
            if (docs == null || docs.isEmpty) {
              return const Text('No data');
            }

            List<Widget> widgets = [];

            for (var doc in docs) {
              models
                  .add(UserModel.fromJson(doc.data() as Map<String, dynamic>));

              final model = UserModel.fromJson(
                doc.data() as Map<String, dynamic>,
              );

              widgets.add(
                UserWidget(
                  onClick: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SendNotificationScreen(
                                token: model.token,
                              ))),
                  model: model,
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: widgets,
              ),
            );
          },
        ),
      ),
    );
  }
}
