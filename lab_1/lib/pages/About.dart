import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab_1/models/audit_class.dart';
import 'package:lab_1/utils/DatabaseHelper.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<StatefulWidget> createState() => _AboutState();
}

class _AboutState extends State<About> {
  DatabaseHelper db = DatabaseHelper.instance;

  void _createAudit(String s) {
    db.create(AuditClass(audit: "El usuario prefiere $s"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('About'),
      ),
      body: Center(
        child: Card(
          elevation: 20,
          margin: const EdgeInsets.all(25),
          child: ListTile(
            leading: SvgPicture.asset(
              'assets/icons/x_icon.svg',
              height: 75,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            title: Text('Tomás Concha',
                style: Theme.of(context).textTheme.headlineMedium),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hola, soy el creador de esta app, estudio IDVRV en la Universidad de Talca, y quiero que me respondas una pregunta...\n¿Qué te gusta más? ¿Lo dulce o lo salado?',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Dulce o Salado?",
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  onFieldSubmitted: _createAudit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
