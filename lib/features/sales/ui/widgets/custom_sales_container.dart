
import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';

class CustomSalesContainer extends StatelessWidget {
  const CustomSalesContainer({
    super.key, required this.title, required this.num,
  });
  final String title;
  final String num;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.kGreyElevatedButtonDarkMode,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Text(title,style: TextStyle(fontSize: 15),),
          Text(num,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
        ],),
      ),
    );
  }
}
