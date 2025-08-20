import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/services/image_services.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/products/logic/providers/product_providers.dart';
import 'package:small_managements/generated/l10n.dart';

class AddImagePicker extends ConsumerWidget {
  const AddImagePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePath = ref.watch(pickImageProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: DottedBorder(
        options: RectDottedBorderOptions(
          color: isDark
              ? AppColors.kGreyElevatedButtonDarkMode
              : AppColors.kUnselectedItemLightMode,
          dashPattern: [10, 5],
          strokeWidth: 2,
          padding: EdgeInsets.all(16),
        ),
        child: Center(
          child: imagePath == null
              ? Column(
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
                        backgroundColor: isDark
                            ? AppColors.kGreyElevatedButtonDarkMode
                            : AppColors.kGreyElevatedButtonLightMode,
                      ),
                      onPressed: () async {
                        final image = await ImageServices.pickImageFromGalary();
                        if (image != null) {
                          final path =
                              await ImageServices.saveImageIntoAppDirectory(
                                image,
                              );
                          ref.read(pickImageProvider.notifier).state = path;
                        }
                      },
                      child: Text(
                        S.of(context).addImage,
                        style: TextStyle(
                          color: isDark
                              ? Colors.white
                              : AppColors.kBlackTextLightMode,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 48),
                    SizedBox(height: 12),
                    Text(
                      S.of(context).imageSelected,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        ref.read(pickImageProvider.notifier).state = null;
                      },
                      icon: Icon(Icons.delete, color: Colors.white),
                      label: Text(
                        S.of(context).deleteImage,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
