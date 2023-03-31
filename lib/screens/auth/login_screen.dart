import 'package:auto_route/auto_route.dart';
import 'package:chatiques/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  final String title;

  const LoginScreen({Key? key, this.title = 'Login'}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(
              text: 'Sign in',
              onPressed: () {},
              leftIcon: Icons.login,
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
