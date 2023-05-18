import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movieapp/pages/sign_in_page.dart';
import 'package:movieapp/pages/sign_up_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // intially show the sign in page
  bool showSignInPage = true;

  void toggleScreens() {
    setState(() {
      showSignInPage = !showSignInPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignInPage) {
      return SignInPage(showSignUpPage: toggleScreens);
    } else {
      return SignUpPage(showSignInPage: toggleScreens);
    }
  }
}
