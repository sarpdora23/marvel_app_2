import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

void login(
    {required String email,
    required String password,
    required String username}) {}

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //testcommenttt
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                height: 500,
                child: Placeholder(),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Login to MarvelBox",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              TextField(
                  //Getting e-mail from user
                  controller: emailController,
                  decoration: InputDecoration(label: Text("E-mail"))),
              TextField(
                  //Getting password from user
                  controller: passwordController,
                  decoration: InputDecoration(label: Text("Password"))),
              ElevatedButton(
                  //login button
                  onPressed: () {
                    login(
                        email: emailController.text,
                        username: usernameController.text,
                        password: passwordController.text);
                  },
                  child: Text("Login"))
            ]),
          ),
        ),
      ),
    );
  }
}
