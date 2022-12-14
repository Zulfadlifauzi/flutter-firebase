import 'package:donationapp/screen/sign_up_screen.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'front_login_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? FrontLoginScreen(
          onClickedSignIn: toggle,
        )
      : SignUpScreen(onClickedSignUp: toggle);

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}
