
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/services/image_services.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/products/logic/product_notifier.dart';
import 'package:small_managements/generated/l10n.dart';

class AddImagePicker extends StatelessWidget {
  const AddImagePicker({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: DottedBorder(
        options: RectDottedBorderOptions(
          color: AppColors.kIncreaseContainerColor,
          dashPattern: [10, 5],
          strokeWidth: 2,
          padding: EdgeInsets.all(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Text(
              S.of(context).addImage,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(S.of(context).tapToAdd),
            SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    AppColors.kIncreaseContainerColor,
              ),
              onPressed: () async {
                final image =
                    await ImageServices.pickImageFromGalary();
                if (image != null) {
                  final path =
                      await ImageServices.saveImageIntoAppDirectory(
                        image,
                      );
                  ref.read(pickImageProvider.notifier).state =
                      path;
                }
              },
              child: Text(
                S.of(context).addImage,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}