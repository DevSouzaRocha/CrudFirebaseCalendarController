// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:obras_app/Calendar/CalendarScreen/EventsConstructor.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Pdf {
  final pdf = pw.Document();

  void generatePdf(ValueNotifier<List<Event>> eventos) async {
    List<List<String>> eventMatrix = [];

    eventMatrix = List.generate(
        eventos.value.length + 1,
        (i) => [
              i == 0 ? "ID" : eventos.value[i - 1].title,
              i == 0 ? "Data Limite" : eventos.value[i - 1].date,
              i == 0 ? "Status" : eventos.value[i - 1].status
            ]);

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Table.fromTextArray(
            data: eventMatrix,
            tableWidth: pw.TableWidth.max,
            cellAlignment: pw.Alignment.center,
          );
        }));

    String? outputfile = await FilePicker.platform
        .saveFile(dialogTitle: 'Save', fileName: 'Lista_de_Obras');

    final file = File(outputfile!);
    await file.writeAsBytes(await pdf.save());
  }
}
