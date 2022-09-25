import 'package:firebase_tutroial/models/user.dart';
import 'package:flutter/material.dart';

class UserWidget extends StatelessWidget {
  final UserModel model;
  final VoidCallback onClick;
  const UserWidget({
    Key? key,
    required this.onClick,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text('Name: ${model.name}'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text('Registered at: ${model.createdAt}'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text('Runs on: ${model.platform}'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                    'Token: ${model.token.isNotEmpty ? model.token.substring(0, 10) : ''}'),
              ),
              ElevatedButton(
                onPressed: onClick,
                child: const Text('Send Notification'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
