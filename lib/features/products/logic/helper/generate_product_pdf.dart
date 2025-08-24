import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:small_managements/features/products/model/product_model.dart';


Future<void> generateAndPreviewProductPdf(List<ProductModel> products) async {
  final pdf = pw.Document();

  // نحسب إجمالي الكميات
  final totalQuantity = products.fold<int>(
    0,
    (sum, item) => sum + (int.tryParse(item.quantity) ?? 0),
  );

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "Products Report",
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              headers: ["Product", "Category", "Quantity"],
              data: products
                  .map((p) => [
                        p.productName,
                        p.category,
                        p.quantity,
                      ])
                  .toList(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
              cellAlignment: pw.Alignment.centerLeft,
              cellStyle: pw.TextStyle(fontSize: 12),
              border: pw.TableBorder.all(color: PdfColors.grey),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              "Total Quantity: $totalQuantity",
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
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
