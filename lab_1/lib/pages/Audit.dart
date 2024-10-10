import 'package:flutter/material.dart';

class Audit extends StatefulWidget {
  const Audit({super.key});

  @override
  State<StatefulWidget> createState() => _AuditState();
}

class _AuditState extends State<Audit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // persistentFooterButtons: [
      //   ElevatedButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       child: const Icon(Icons.keyboard_return))
      // ],
      body: Center(
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
