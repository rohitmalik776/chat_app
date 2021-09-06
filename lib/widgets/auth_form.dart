import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm(this.submitAuthForm, this.isLoading, {Key? key})
      : super(key: key);
  final bool isLoading;
  final void Function({
    required String username,
    required String email,
    required String password,
    required bool isLogin,
  }) submitAuthForm;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitAuthForm(
        username: _username.trim(),
        password: _userPass.trim(),
        email: _userEmail.trim(),
        isLogin: _isLogin,
      );
      // Navigator.of(context).pushNamed(ChatScreen.routeName);
    }
  }

  var _isLogin = true;
  var _userEmail = '';
  var _username = '';
  var _userPass = '';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty && !value.contains('@')) {
                          return 'Please enter valid email address!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email Address'),
                      onSaved: (value) {
                        _userEmail = value!;
                      }),
                  if (!_isLogin)
                    TextFormField(
                        key: ValueKey('username'),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 5) {
                            return 'Please enter valid username!';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(labelText: 'Username'),
                        onSaved: (value) {
                          _username = value!;
                        }),
                  TextFormField(
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Password must be of at least 8 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      onSaved: (value) {
                        _userPass = value!;
                      }),
                  SizedBox(height: 20),
                  widget.isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          child: Text(_isLogin ? 'Login' : 'Sign up'),
                          onPressed: _trySubmit,
                        ),
                  if (!widget.isLoading)
                    TextButton(
                      child: Text(_isLogin ? 'Sign up now!' : 'Login instead!',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor)),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    )
                ],
              ),
            ),
          ),
        ),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}
