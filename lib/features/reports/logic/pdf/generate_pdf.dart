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
  required List<SoldProductModel>soldProducts
}) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Text(
              'Date Range : $startDate To $endDate',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.Row(
              children: [
                pw.Text('Total Sales ', style: pw.TextStyle(fontSize: 16)),
                pw.Spacer(),
                pw.Text(
                  '$totalSales LE',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 5),

            pw.Row(
              children: [
                pw.Text(
                  'Total Product Sold ',
                  style: pw.TextStyle(fontSize: 16),
                ),
                pw.Spacer(),
                pw.Text(
                  '$totalProductSold Item',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
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
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 10),
          pw.SizedBox(
                height: 400,
                child: pw.ListView.separated(
                  itemBuilder: (context, index) {
                    return pw. Row(
                      children: [
                        pw.Text(soldProducts[index].productName),
                        pw.Spacer(),
                        pw.Text("${soldProducts[index].quantity} Items Sold"),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => pw.Divider(),
                  itemCount: soldProducts.length,
                ),
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
