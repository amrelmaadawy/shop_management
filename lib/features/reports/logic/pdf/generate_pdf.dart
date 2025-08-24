import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:small_managements/features/sales/model/sold_product_model.dart';

Future<void> generateAndPreviewPdf({
  required String totalSales,
  required String totalProductSold,
  required String totalProfit,
  required String startDate,
  required String endDate,
  required List<SoldProductModel> soldProducts,
}) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Date Range : $startDate To $endDate',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10),

            pw.Row(
              children: [
                pw.Text('Total Sales ', style: pw.TextStyle(fontSize: 16)),
                pw.Spacer(),
                pw.Text(
                  '$totalSales LE',
                  style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
            pw.SizedBox(height: 5),

            pw.Row(
              children: [
                pw.Text('Total Product Sold ', style: pw.TextStyle(fontSize: 16)),
                pw.Spacer(),
                pw.Text(
                  '$totalProductSold Item',
                  style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
            pw.SizedBox(height: 5),

            pw.Row(
              children: [
                pw.Text('Total Profit ', style: pw.TextStyle(fontSize: 16)),
                pw.Spacer(),
                pw.Text(
                  '$totalProfit LE',
                  style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
            pw.SizedBox(height: 20),

            // جدول المنتجات
            pw.TableHelper.fromTextArray(
              headers: ["Product", "Quantity", "Selling Price", "Total"],
              data: soldProducts.map((p) {
                final qty = p.quantity;
                final price = p.sellingPrice;
                final total = qty * price;

                return [
                  p.productName,
                  p.quantity,
                  "${p.sellingPrice} LE",
                  "$total LE",
                ];
              }).toList(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
              border: pw.TableBorder.all(color: PdfColors.grey),
              cellAlignment: pw.Alignment.centerLeft,
              cellStyle: pw.TextStyle(fontSize: 12),
            ),
          ],
        );
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
