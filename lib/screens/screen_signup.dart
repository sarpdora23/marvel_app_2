import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marvel_app_2/utilities/colors.dart';
import 'package:marvel_app_2/screens/screen_login.dart';
import 'package:marvel_app_2/utilities/image.dart';
import 'package:marvel_app_2/utilities/colors.dart';

void signUp(
    {required String email,
    required String password,
    required String username}) {}

class SignUpScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
//lalalala
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: bgColor,
          child: Column(children: [
            Container(
              height: 450,
              child: Image.network(
                blueImageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Sign up to MarvelBox",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                    TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            label: Text(
                          "Email Adress",
                          style: TextStyle(color: grayishColor),
                        ))),
                    TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                            label: Text(
                          "Username",
                          style: TextStyle(color: grayishColor),
                        ))),
                    TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            label: Text("Password",
                                style: TextStyle(color: grayishColor)))),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "I'm at least 16 years old and accept the Term of Usaage",
                            style: TextStyle(color: grayishColor),
                          ),
                          Text(
                            "I accept the Privacy Policy and consent to the processing my personal information in accordance with ite",
                            style: TextStyle(color: grayishColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                    ),
                    onPressed: () {
                      signUp(
                          email: emailController.text,
                          username: usernameController.text,
                          password: passwordController.text);
                    },
                    child: Text("Confirm")),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: buttonColor),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LoginScreen())),
                    child: Text("Login")),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
