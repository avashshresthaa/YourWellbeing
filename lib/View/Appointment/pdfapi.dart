import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PdfApi {
  static Future<File> generateCenteredText(
    String hospitalName,
    String patientName,
    String age,
    String gender,
    String appointmentDate,
    String appointmentTime,
    String assignedDoctor,
    String patientId,
    String qr,
  ) async {
    final pdf = pw.Document();
    final font = await rootBundle.load("fonts/nutinosans_regular.ttf");
    final ttf = pw.Font.ttf(font);
    pdf.addPage(pw.MultiPage(
        //  pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
      return [
        pw.Header(
            child: pw.Text('$hospitalName',
                style: pw.TextStyle(
                    fontSize: 25, fontWeight: pw.FontWeight.bold))),
        pw.Paragraph(
            text: 'Name: $patientName', style: pw.TextStyle(fontSize: 18)),
        pw.Paragraph(text: 'Age: $age', style: pw.TextStyle(fontSize: 18)),
        pw.Paragraph(
            text: 'Gender: $gender', style: pw.TextStyle(fontSize: 18)),
        pw.Paragraph(
            text: 'Appointment Date: $appointmentDate',
            style: pw.TextStyle(fontSize: 18)),
        pw.Paragraph(
            text: 'Appointment Time: $appointmentTime',
            style: pw.TextStyle(fontSize: 18)),
        pw.Paragraph(
            text: 'Assigned Doctor: $assignedDoctor',
            style: pw.TextStyle(fontSize: 18)),
        pw.Paragraph(
            text: 'Patient Id: $patientId', style: pw.TextStyle(fontSize: 18)),
        pw.SizedBox(height: 30),
        pw.Paragraph(text: 'QR code:', style: pw.TextStyle(fontSize: 25)),
        pw.BarcodeWidget(
          height: 200,
          width: 200,
          color: PdfColor.fromHex("#000000"),
          barcode: pw.Barcode.qrCode(),
          data: "$qr",
        ),
        pw.SizedBox(height: 50),
        pw.Footer(
          title: pw.Text('Please do not share this page'),
        )
      ];
    }));
    return saveDocument(name: 'my_appointment.pdf', pdf: pdf);
  }

  static Future<File> saveDocument(
      {required String name, required pw.Document pdf}) async {
    final byte = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(byte);
    return file;
  }

  static Future<void> openFile(File pdfFile) async {
    final url = pdfFile.path;
    await OpenFile.open(url);
    print('hey,mi');
  }
}
