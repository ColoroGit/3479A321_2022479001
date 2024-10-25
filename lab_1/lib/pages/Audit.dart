import 'package:flutter/material.dart';
import 'package:lab_1/models/provider.dart';
import 'package:provider/provider.dart';

class Audit extends StatefulWidget {
  const Audit({super.key});

  @override
  State<StatefulWidget> createState() => _AuditState();
}

class _AuditState extends State<Audit> {
  List<Widget> showAudit() {
    var texts = <Widget>[];

    for (int i = 0; i < context.read<AppData>().actions.length; i++) {
      texts.add(Text(context.read<AppData>().actions[i]));
    }

    return texts;
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
          children: showAudit(),
        ),
      ),
    );
  }
}
