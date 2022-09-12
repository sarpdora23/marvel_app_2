import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marvel_app_2/screens/screen_overview_popular.dart';
import 'package:marvel_app_2/screens/screen_signup.dart';
import 'package:marvel_app_2/utilities/colors.dart';
import 'package:marvel_app_2/screens/screen_login.dart';
import 'package:marvel_app_2/utilities/image.dart';
import 'package:marvel_app_2/utilities/colors.dart';

void login({
  required String email,
  required String password,
}) {}

class LoginScreen extends StatelessWidget {
  static final routeName = "/login";
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
                        "Login to MarvelBox",
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
                        controller: passwordController,
                        decoration: InputDecoration(
                            label: Text("Password",
                                style: TextStyle(color: grayishColor)))),
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
                      login(
                          email: emailController.text,
                          password: passwordController.text);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => PopularScreen())));
                    },
                    child: Text("Confirm")),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => SignUpScreen())));
                    },
                    child: Text("Sign up")),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
