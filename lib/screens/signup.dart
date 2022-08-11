import 'package:firebase_tutroial/screens/home.dart';
import 'package:firebase_tutroial/services/firebase_helper.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController nameController;

  bool isLoading = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text('Sign up using email and password'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'example@email.com',
                    labelText: 'Enter your mail',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: '*******',
                    labelText: 'Enter your password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Mark Smith',
                    labelText: 'Enter your name',
                  ),
                ),
              ),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if (!isValidForm(context)) {
                          setState(() {
                            isLoading = false;
                          });
                          return;
                        }

                        try {
                          final isSaved = await FirebaseHelper.saveUser(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text,
                          );

                          if (isSaved && mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }

                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: const Text('Sign up'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidForm(BuildContext context) {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fill all fields'),
        ),
      );
      return false;
    }

    if (passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must be at least 8 characters length'),
        ),
      );
      return false;
    }

    return true;
  }
}
