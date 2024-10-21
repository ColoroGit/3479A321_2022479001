import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences extends StatefulWidget {
  const Preferences({super.key});

  @override
  State<StatefulWidget> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  var _counter = 0;
  var _username = "";

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? '';
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  void _updateUserName(String newName) {
    setState(() {
      _username = newName;
    });
    _savePreferences();
  }

  void _updateCounter(double newValue) {
    setState(() {
      _counter = newValue.round();
    });
    _savePreferences();
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('username', _username);
      prefs.setInt('counter', _counter);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Preferences'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Username: $_username"),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 0, bottom: 30, left: 30, right: 30),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Write Your Username",
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                onFieldSubmitted: _updateUserName,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 30, bottom: 0, left: 8, right: 8),
              child: Text("Counter: $_counter"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Slider(
                value: _counter.toDouble(),
                min: 0,
                max: 100,
                onChanged: _updateCounter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
