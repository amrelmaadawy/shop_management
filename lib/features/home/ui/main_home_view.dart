import 'package:flutter/material.dart';

class MainHomeView extends StatelessWidget {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(children: [Text(''),IconButton(onPressed: (){}, icon: Icon(Icons.settings))],)
          ],),
        ),
      )
    );
  }
}