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
              "Returned Sales Report",
              style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Text("Period: $startDate → $endDate",
              style: const pw.TextStyle(fontSize: 14)),

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
                pw.Text("Total Refund: $totalRefund",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text("Total Products Returned: $totalProductsReturned",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text("Total Profit Reduced: $totalProfitReduced",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ],
            ),
          ),

          pw.SizedBox(height: 20),

          /// جدول المرتجعات
          ...returnTransactions.map((transaction) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
              
                pw.Text("Date: ${formatDateTimeTo12Hour(transaction.date.toLocal())}"),

                pw.SizedBox(height: 10),
                pw.TableHelper.fromTextArray(
                  border: pw.TableBorder.all(width: 1, color: PdfColors.black),
                  headers: ["Product", "Qty", "Price", "Profit Reduced"],
                  data: transaction.products.map((p) {
                    return [
                      p.name,
                      p.quantity.toString(),
                      p.price.toStringAsFixed(2),
                      "-${p.profitReduced.toStringAsFixed(2)}"
                    ];
                  }).toList(),
                ),
                pw.SizedBox(height: 10),

                pw.Text("Refund: ${transaction.totalRefund}",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text("Profit Reduced: ${transaction.totalProfitReduced}",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
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
