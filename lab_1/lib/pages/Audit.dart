import 'package:flutter/material.dart';
import 'package:lab_1/models/audit_class.dart';
import 'package:lab_1/utils/DatabaseHelper.dart';

class Audit extends StatefulWidget {
  const Audit({super.key});

  @override
  State<StatefulWidget> createState() => _AuditState();
}

class _AuditState extends State<Audit> {
  DatabaseHelper db = DatabaseHelper.instance;
  List<AuditClass> audits = [];

  refreshNotes() {
    db.readAll().then((value) {
      setState(() {
        audits = value;
      });
    });
  }

  readAudits() {
    final auditsTexts = <Widget>[];

    for (int i = 0; i < audits.length; i++) {
      auditsTexts.add(Text(
        "${audits[i].audit}",
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ));
    }

    return auditsTexts;
  }

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Audit'),
      ),
      body: Center(
        child: ListView(
          children: readAudits(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          db.deleteAll();
          refreshNotes();
          readAudits();
        },
        child: const Icon(Icons.delete_forever),
      ),
    );
  }
}
