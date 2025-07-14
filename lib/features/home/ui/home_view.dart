import 'package:flutter/material.dart';
import 'package:small_managements/features/home/ui/widgets/home_buttons.dart';
import 'package:small_managements/features/home/ui/widgets/home_item.dart';
import 'package:small_managements/generated/l10n.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
              HomeItem(
                title: S.of(context).TotalSalesToday,
                numbers: '1000LE',
                description: S.of(context).compareTo,
                imagePath: 'assets/images/top sales.png',
                percentage: '+ 16%',
              ),
              HomeItem(
                title: S.of(context).Totalproduct,
                numbers: '253',
                description: S.of(context).itemsInclude,
                imagePath: 'assets/images/sales.png',
                percentage: '+ 2%',
              ),
              HomeItem(
                title: S.of(context).salesSummary,
                numbers: '5000LE',
                description: S.of(context).thisWeek,
                imagePath: 'assets/images/product.png',
                percentage: '+ 10%',
              ),
              SizedBox(height: 20,),
              HomeButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
