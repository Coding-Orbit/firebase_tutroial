import 'dart:io';

import 'package:firebase_tutroial/services/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SendNotificationScreen extends StatefulWidget {
  final String token;
  const SendNotificationScreen({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  late final TextEditingController title;
  late final TextEditingController body;
  late final ImagePicker _picker;

  @override
  void initState() {
    title = TextEditingController();
    body = TextEditingController();
    _picker = ImagePicker();
    super.initState();
  }

  XFile? xFile;
  bool isLoading = false;
  String image = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Notification to device'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  key: UniqueKey(),
                  keyboardType: TextInputType.text,
                  controller: title,
                  decoration: InputDecoration(
                    labelText: 'Enter Notification Title',
                    hintText: 'Your title',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  key: UniqueKey(),
                  keyboardType: TextInputType.text,
                  controller: body,
                  decoration: InputDecoration(
                    labelText: 'Enter Notification body',
                    hintText: 'Your body',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  maxLines: 3,
                ),
              ),
              InkWell(
                onTap: () async {
                  isLoading = true;
                  setState(() {});

                  xFile = await _picker.pickImage(source: ImageSource.gallery);
                  if (xFile != null) {
                    setState(() {});

                    ///Upload to fire storage
                    final String? url =
                        await FirebaseHelper.uploadImage(File(xFile!.path));

                    if (url != null) {
                      image = url;
                      isLoading = false;
                      setState(() {});
                      return;
                    }
                  }

                  isLoading = false;
                  setState(() {});
                },
                child: Container(
                  height: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(width: 8, color: Colors.black12),
                    borderRadius: BorderRadius.circular(12.0),
                    image: xFile?.path != null
                        ? DecorationImage(
                            image: FileImage(
                              File(xFile!.path),
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: xFile?.path != null
                      ? null
                      : const Center(
                          child: Icon(Icons.photo),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => FirebaseHelper.sendNotification(
                          title: title.text,
                          body: body.text,
                          token: widget.token,
                          image: image,
                        ),
                        child: const Text('Send Notifications'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
