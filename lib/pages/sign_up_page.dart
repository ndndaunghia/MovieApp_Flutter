import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/const/colors.dart';
import 'package:movieapp/pages/sign_in_page.dart';
import 'package:email_validator/email_validator.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback showSignInPage;
  const SignUpPage({super.key, required this.showSignInPage});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future signUp() async {
    String name = nameController.text.trim();
    String password = passwordController.text.trim();
    String email = emailController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    if (name.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 32,
            ),
            title: const Text('Error'),
            content: const Text('Please fill Name field !'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          );
        },
      );
      return;
    }
    if (!EmailValidator.validate(email)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 32,
            ),
            title: const Text('Error'),
            content: const Text('Please enter a valid email address'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          );
        },
      );
      return;
    }

    if (password.length < 6) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 32,
            ),
            title: const Text('Error'),
            content: const Text('Password must be at least 6 characters long'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          );
        },
      );
      return;
    }
    if (password == confirmPassword) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password);
      await FirebaseFirestore.instance.collection('users').add({
        'name': name,
        'email': email,
        'password': password,
      });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              icon: const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 32,
              ),
              title: const Text('Error'),
              content: const Text('Password and Confirm Password do not match'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                        )))
              ],
            );
          });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        // backgroundColor: bgColor,
        child: Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                  child: Icon(
                Icons.movie,
                size: 100,
                color: Colors.red,
              )),
              Text(
                'Movie App',
                style: GoogleFonts.bebasNeue(
                  color: Colors.red,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              const Text('Enjoy the world of movies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),

              // First Name TextField
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: TextField(
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      controller: nameController,
                      decoration: const InputDecoration(
                        icon: Padding(
                          padding: EdgeInsets.only(left: 12.0),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Name',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),

              // Email TextField
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      controller: emailController,
                      decoration: const InputDecoration(
                        icon: Padding(
                          padding: EdgeInsets.only(left: 12.0),
                          child: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),

              // Password TextField
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: TextField(
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      controller: passwordController,
                      decoration: const InputDecoration(
                        icon: Padding(
                          padding: EdgeInsets.only(left: 12.0),
                          child: Icon(
                            Icons.password,
                            color: Colors.white,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.white),
                        // prefixIcon: Icon(
                        //   Icons.password,
                        //   color: Colors.white,
                        // ),
                      ),
                    ),
                  ),
                ),
              ),

              // Confirm Password TextField
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: TextField(
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      controller: confirmPasswordController,
                      decoration: const InputDecoration(
                        icon: Padding(
                          padding: EdgeInsets.only(left: 12.0),
                          child: Icon(
                            Icons.password,
                            color: Colors.white,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),

              // Sign Up Button
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      signUp();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              // Already have an account
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                  GestureDetector(
                    onTap: () {
                      widget.showSignInPage();
                    },
                    child: const Text("Sign In",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
