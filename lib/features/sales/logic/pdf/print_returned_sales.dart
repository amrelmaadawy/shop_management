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
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return [
          /// العنوان الرئيسي
          pw.Center(
            child: pw.Text(
              "تقرير المبيعات المُرتجعة",
              style: pw.TextStyle(
                fontSize: 22,
                fontWeight: pw.FontWeight.bold,
                font: font,
              ),
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Text("الفترة: $startDate → $endDate",
              style: pw.TextStyle(fontSize: 14, font: font)),

          pw.SizedBox(height: 20),

          /// ملخص المرتجعات
          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black, width: 1),
              borderRadius: pw.BorderRadius.circular(6),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("إجمالي المبالغ المُرتجعة: $totalRefund",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: font)),
                pw.Text("إجمالي المنتجات المُرتجعة: $totalProductsReturned",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: font)),
                pw.Text("إجمالي الأرباح المخصومة: $totalProfitReduced",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: font)),
              ],
            ),
          ),

          pw.SizedBox(height: 20),

          /// جدول المرتجعات
          ...returnTransactions.map((transaction) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("التاريخ: ${formatDateTimeTo12Hour(transaction.date.toLocal())}",
                    style: pw.TextStyle(font: font)),

                pw.SizedBox(height: 10),
                pw.TableHelper.fromTextArray(
                  border: pw.TableBorder.all(width: 1, color: PdfColors.black),
                  headers: ["المنتج", "الكمية", "السعر", "الأرباح المخصومة"],
                  data: transaction.products.map((p) {
                    return [
                      p.name,
                      p.quantity.toString(),
                      p.price.toStringAsFixed(2),
                      "-${p.profitReduced.toStringAsFixed(2)}"
                    ];
                  }).toList(),
                  headerStyle: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, font: font),
                  cellStyle: pw.TextStyle(font: font),
                ),
                pw.SizedBox(height: 10),

                pw.Text("المبلغ المُرتجع: ${transaction.totalRefund}",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: font)),
                pw.Text("الأرباح المخصومة: ${transaction.totalProfitReduced}",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: font)),
                pw.Divider(),
                pw.SizedBox(height: 15),
              ],
            );
          }),
        ];
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
