import 'package:flutter/material.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/AuthScreen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void _submitAuthForm({
    required String username,
    required String email,
    required String password,
    required bool isLogin,
  }) {
    // TODO: Wire up the Firebase auth
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthForm(_submitAuthForm),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
