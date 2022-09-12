import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PopularScreen extends StatelessWidget {
  const PopularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text("Popular"),
        leading: Placeholder(),
        actions: [Icon(Icons.search)],
      ),
      body: PopularScreenBody(),
    );
  }
}

class PopularScreenBody extends StatelessWidget {
  const PopularScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          height: 60,
          child: Row(children: [
            TestTextWidgetWillDelete("hi"),
            TestTextWidgetWillDelete("lalalalala"),
            TestTextWidgetWillDelete("ofcfofcofc"),
            TestTextWidgetWillDelete("nvmv")
          ]),
        ),
        Container(
          width: 300,
          height: 300,
          child: PageView(
            children: [
              Center(
                child: Container(width: 100, height: 100, color: Colors.black),
              ),
              Center(
                child: Container(width: 100, height: 100, color: Colors.red),
              ),
              Center(
                child: Container(width: 100, height: 100, color: Colors.yellow),
              )
            ],
          ),
        )
      ],
    ));
  }
}

class TestTextWidgetWillDelete extends StatelessWidget {
  String text;
  TestTextWidgetWillDelete(this.text);
  get lenght => text.length;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => {},
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ));
  }
}
