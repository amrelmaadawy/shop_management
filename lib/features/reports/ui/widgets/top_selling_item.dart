import 'package:flutter/material.dart';
import 'package:small_managements/generated/l10n.dart';

class TopSellingItem extends StatelessWidget {
  const TopSellingItem({super.key, required this.productName, required this.image, required this.quantitySold});
  final String productName;
  final Widget image;
  final int quantitySold;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          ClipRRect(
            child:image ,
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(productName),
              SizedBox(height: 5),
              Text('$quantitySold  ${S.of(context).sold}'),
            ],
          ),
        ],
      ),
    );
  }
}
