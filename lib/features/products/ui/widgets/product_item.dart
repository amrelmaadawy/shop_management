import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.image, required this.productName, required this.quantity});
  final String image;
  final String productName;
  final String quantity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: Row(
        children: [
          Image.asset('assets/images/apple.png'),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Apple Orange',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '\$12.99 . 10 in stock',
                style: TextStyle(color: AppColors.kPrimeryColor, fontSize: 14),
              ),
            ],
          ),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
        ],
      ),
    );
  }
}
