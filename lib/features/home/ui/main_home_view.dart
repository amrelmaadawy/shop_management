import 'package:flutter/material.dart';
import 'package:small_managements/features/home/ui/widgets/home_item.dart';
import 'package:small_managements/generated/l10n.dart';

class MainHomeView extends StatelessWidget {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).homeAppBar,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              HomeItem(),
            ],
          ),
        ),
      ),
    );
  }
}
