import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:lab_1/models/hollyday.dart';
import 'package:http/http.dart' as http;

class Hollydays extends StatefulWidget {
  const Hollydays({super.key});

  @override
  State<StatefulWidget> createState() => _HollydaysState();
}

class _HollydaysState extends State<Hollydays> {
  late Future<List<Hollyday>> hollydays;

  int year = 2024;

  @override
  void initState() {
    super.initState();
    hollydays = fetchHollydays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Hollydays'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Feridaos del año",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        showMaterialNumberPicker(
                          context: context,
                          title: 'Pick Your Age',
                          maxNumber: 2024,
                          minNumber: 2000,
                          selectedNumber: year,
                          onChanged: (value) => setState(() => year = value),
                        ).then((_) {
                          setState(() {
                            hollydays = fetchHollydays();
                          });
                        });
                      },
                      child: Text(
                        "$year",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 40),
                      ))
                ],
              ),
            ),
            FutureBuilder<List<Hollyday>>(
              future: hollydays,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: 500,
                    child: ListView(children: getHollydaysTiles(snapshot.data)),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Hollyday>> fetchHollydays() async {
    final response = await http
        .get(Uri.parse('https://apis.digital.gob.cl/fl/feriados/$year'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonDecoded =
          jsonDecode(response.body) as List<dynamic>;
      return jsonDecoded
          .map(
              (dynamic item) => Hollyday.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  getHollydaysTiles(List<Hollyday>? data) {
    var hlt = <Widget>[];

    if (data == null) return;

    for (var h in data) {
      hlt.add(
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            child: ListTile(
              leading: Text(
                h.date.substring(("2024-").length),
                style: const TextStyle(fontSize: 35),
              ),
              title: Text(
                h.name,
                style: const TextStyle(fontSize: 25),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Irrenunciable: ${(h.irrenunciable ? "Si" : "No")}",
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    "Tipo: ${h.type}",
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    return hlt;
  }
}
