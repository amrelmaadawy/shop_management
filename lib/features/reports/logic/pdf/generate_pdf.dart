import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:small_managements/features/sales/model/sold_product_model.dart';
Future<void> generateAndPreviewPdf(List<SoldProductModel> sales) async {
  final pdf = pw.Document();
  final arabicFont = pw.Font.ttf(await rootBundle.load("assets/fonts/Amiri-Regular.ttf"));

  final totalSales = sales.fold<double>(
    0,
    (sum, item) => sum + (item.total),
  );

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return pw.Directionality(
          textDirection: pw.TextDirection.rtl,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "تقرير المبيعات",
                style: pw.TextStyle(font: arabicFont, fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: ["المنتج", "الكمية", "الإجمالي"],
                data: sales.map((s) => [s.productName, s.quantity, s.total]).toList(),
                headerStyle: pw.TextStyle(font: arabicFont, fontWeight: pw.FontWeight.bold),
                headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
                cellStyle: pw.TextStyle(font: arabicFont, fontSize: 12),
                border: pw.TableBorder.all(color: PdfColors.grey),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                "إجمالي المبيعات: $totalSales",
                style: pw.TextStyle(font: arabicFont, fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
            ],
          ),
        );
      },
    ),
  );

  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
}
