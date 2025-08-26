import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_managements/features/reports/logic/pdf/generate_pdf.dart';
import 'package:small_managements/features/sales/model/sold_product_model.dart';

class PrintIcon extends StatelessWidget {
  const PrintIcon({
    super.key,
 
   required this.soldProducts,
  });

  
  final List<SoldProductModel> soldProducts;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: IconButton(
        onPressed: () async {
          
          await generateAndPreviewPdf(
           soldProducts
          );
        },
        icon: Icon(CupertinoIcons.printer),
      ),
    );
  }
}
