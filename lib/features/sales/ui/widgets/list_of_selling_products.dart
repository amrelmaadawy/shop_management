
import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/products/model/product_model.dart';

class ListOfSellingProducts extends StatelessWidget {
  const ListOfSellingProducts({
    super.key,
    required this.product,
  });

  final List<ProductModel> product;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product[index].productName),
                  SizedBox(height: 5),
                  Text(
                    'individual Price${product[index].price} LE',
                  ),
                ],
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.kIncreaseContainerColor,
                ),
                child: Text(
                  '-',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '2',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.kIncreaseContainerColor,
                ),
                child: Text(
                  '+',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        childCount: product.length,
      ),
    );
  }
}