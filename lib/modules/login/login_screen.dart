import 'package:flutter/material.dart';
import 'package:todo_sqflite/shared/components/compnents.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool _isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  defualtTextFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    text: 'Email',
                    prefix: Icons.mail,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'email must not be';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defualtTextFormField(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    isPassowrd: _isPassword,
                    text: 'Password',
                    prefix: Icons.lock,
                    suffix:
                        _isPassword ? Icons.visibility_off : Icons.visibility,
                    suffixPress: () {
                      setState(() {
                        _isPassword = !_isPassword;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'password must not be';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(function: () {}, text: 'login'),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultButton(function: () {}, text: 'signup'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Register Now',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
