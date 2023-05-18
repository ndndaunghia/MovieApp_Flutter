import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/const/colors.dart';
import 'package:movieapp/pages/sign_up_page.dart';

import 'forgot_pass_page.dart';

class SignInPage extends StatefulWidget {
  final VoidCallback showSignUpPage;
  const SignInPage({super.key, required this.showSignUpPage});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: bgColor,
        body: SafeArea(
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

          // Email TextField
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
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
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

          // forgot password
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordPage(),
                    ),
                  );
                },
                child: const Text("Forgot Password?",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    )),
              ),
              const SizedBox(width: 20.0),
            ],
          ),

          // Sign In Button
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  signIn();
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
                  "Sign In",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Not a member text
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Not a member? ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  )),
              GestureDetector(
                onTap: () {
                  widget.showSignUpPage();
                },
                child: const Text("Sign Up Now",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    )),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
