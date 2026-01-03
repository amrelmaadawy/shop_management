import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:small_managements/core/hive_boxes.dart';
import 'package:small_managements/features/products/model/category_model.dart';
import 'package:small_managements/features/products/model/product_model.dart';
import 'package:small_managements/features/sales/model/return_transaction_model.dart';
import 'package:small_managements/features/sales/model/sales_model.dart';
import 'package:small_managements/features/sales/model/todays_total_sold.dart';

class HiveBackupManager {
  static Future<String?> createAutoBackup() async {
  try {
    final appDir = await getApplicationDocumentsDirectory();

    final backupsRoot =
        Directory('${appDir.path}${Platform.pathSeparator}backups');

    if (!await backupsRoot.exists()) {
      await backupsRoot.create(recursive: true);
    }

    final timestamp =
        DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now());

    final backupDir = Directory(
      '${backupsRoot.path}${Platform.pathSeparator}backup_$timestamp',
    );

    await backupDir.create();

    final hiveFiles = Directory(appDir.path).listSync().where(
          (f) => f.path.endsWith('.hive') || f.path.endsWith('.lock'),
        );

    for (var file in hiveFiles) {
      if (file is File) {
        final fileName =
            file.path.split(Platform.pathSeparator).last;

        await file.copy(
          '${backupDir.path}${Platform.pathSeparator}$fileName',
        );
      }
    }

    if (kDebugMode) {
      print('✅ Backup created: ${backupDir.path}');
    }
    return backupDir.path;
  } catch (e) {
    if (kDebugMode) {
      print('❌ Backup error: $e');
    }
    return null;
  }
}



  static Future<bool> createManualBackup() async {
    try {
      String? selectedPath = await FilePicker.platform.saveFile(
        dialogTitle: 'حفظ نسخة احتياطية',
        fileName:
            'backup_${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
      );

      if (selectedPath == null) return false;

      final backupDir = Directory(selectedPath);
      if (!await backupDir.exists()) {
        await backupDir.create(recursive: true);
      }

      final appDir = await getApplicationDocumentsDirectory();
      final hiveDir = Directory(appDir.path);
      final hiveFiles = hiveDir.listSync().where(
            (f) => f.path.endsWith('.hive') || f.path.endsWith('.lock'),
          );

      for (var file in hiveFiles) {
        if (file is File) {
          final fileName =
              file.path.split(Platform.pathSeparator).last;

          await file.copy(
            '${backupDir.path}${Platform.pathSeparator}$fileName',
          );
        }
      }

      if (kDebugMode) {
        print('✅ Manual backup saved to: ${backupDir.path}');
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Manual backup error: $e');
      }
      return false;
    }
  }

  /// استعادة Backup
 static Future<bool> restoreBackup() async {
  try {
    String? backupFolderPath =
        await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'اختر مجلد النسخة الاحتياطية',
    );

    if (backupFolderPath == null) return false;

    // اقفل Hive
    await Hive.close();

    final appDir = await getApplicationDocumentsDirectory();
    final backupDir = Directory(backupFolderPath);

    final backupFiles = backupDir.listSync();

    for (var file in backupFiles) {
      if (file is File &&
          (file.path.endsWith('.hive') ||
              file.path.endsWith('.lock'))) {
        final fileName =
            file.path.split(Platform.pathSeparator).last;

        final targetFile = File(
          '${appDir.path}${Platform.pathSeparator}$fileName',
        );

        if (await targetFile.exists()) {
          await targetFile.delete();
        }

        await file.copy(targetFile.path);
      }
    }

    await Hive.initFlutter();

  await Hive.openBox<TodaysTotalSold>(totalSoldToday);
  await Hive.openBox<SalesModel>(ksalesBox);
  await Hive.openBox<ProductModel>(productBox);
  await Hive.openBox<CategoryModel>(categoriesBox);
  await Hive.openBox<ReturnTransaction>(kReturnsBox);
  await HiveBackupManager.createAutoBackup();
    if (kDebugMode) {
      print('✅ Backup restored successfully');
    }
    return true;
  } catch (e) {
    if (kDebugMode) {
      print('❌ Restore error: $e');
    }
    return false;
  }
}

  static Future<void> cleanOldBackups({int daysToKeep = 30}) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final backupDir =
          Directory('${appDir.path}${Platform.pathSeparator}backups');

      if (!await backupDir.exists()) return;

      final now = DateTime.now();
      final files = backupDir.listSync();

      for (var file in files) {
        if (file is File) {
          final stat = await file.stat();
          final age = now.difference(stat.modified).inDays;

          if (age > daysToKeep) {
            await file.delete();
            if (kDebugMode) {
              print('🗑️ Deleted old backup: ${file.path}');
            }
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Clean error: $e');
      }
    }
  }

  static Future<void> scheduleAutoBackup() async {
    Future.delayed(const Duration(hours: 24), () async {
      await createAutoBackup();
      await cleanOldBackups();
      scheduleAutoBackup();
    });
  }
}
