import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:small_managements/features/sales/logic/helper/time_converter.dart';
import 'package:small_managements/features/sales/model/return_transaction_model.dart';

Future<void> generateReturnReport({
  required String totalRefund,
  required String totalProductsReturned,
  required String totalProfitReduced,
  required String startDate,
  required String endDate,
  required List<ReturnTransaction> returnTransactions,
}) async {
  final font = pw.Font.ttf(await rootBundle.load("assets/fonts/Amiri-Regular.ttf"));
  final pdf = pw.Document();

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
                "تقرير المبيعات المُرتجعة",
                style: pw.TextStyle(
                  font: font,
                  fontSize: 22,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                "الفترة: $startDate → $endDate",
                style: pw.TextStyle(font: font, fontSize: 14),
              ),
              pw.SizedBox(height: 20),

              pw.TableHelper.fromTextArray(
                headers: ["التاريخ", "المنتج", "الكمية", "السعر", "الأرباح المخصومة", "المبلغ المُرتجع"],
                data: returnTransactions.expand((transaction) {
                  return transaction.products.map((p) {
                    return [
                      formatDateTimeTo12Hour(transaction.date.toLocal()),
                      p.name,
                      p.quantity.toString(),
                      p.price.toStringAsFixed(2),
                      "-${p.profitReduced.toStringAsFixed(2)}",
                      transaction.totalRefund,
                    ];
                  });
                }).toList(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: font),
                cellStyle: pw.TextStyle(font: font, fontSize: 12),
                border: pw.TableBorder.all(color: PdfColors.grey),
                headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
              ),

              pw.SizedBox(height: 20),

              pw.Text(
                "إجمالي المبالغ المُرتجعة: $totalRefund",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: font, fontSize: 14),
              ),
              pw.Text(
                "إجمالي المنتجات المُرتجعة: $totalProductsReturned",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: font, fontSize: 14),
              ),
              pw.Text(
                "إجمالي الأرباح المخصومة: $totalProfitReduced",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: font, fontSize: 14),
              ),
            ],
          ),
        );
      },
    ),
  );

  // بدل layoutPdf استخدم sharePdf
  // ده بيفتح preview window فيها خيارات: Print, Save, Share
  await Printing.sharePdf(
    bytes: await pdf.save(),
    filename: 'تقرير_المرتجعات_${DateTime.now().millisecondsSinceEpoch}.pdf',
  );
}