import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab_1/pages/child.dart';
import 'package:logger/logger.dart';
import 'details.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() {
    var logger = Logger();
    logger.d("create state");
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  var logger = Logger();

  int _counter = 0;
  String _message = 'Presiona los botones para jugar';
  // ignore: unused_field
  String _displayedIcon = 'assets/icons/o_icon.svg';

  String oIcon = 'assets/icons/o_icon.svg';
  String winIcon = 'assets/icons/victory_icon.svg';
  String gameOverIcon = 'assets/icons/game_over_icon.svg';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    if (_counter == 5) {
      showGameOverDisplay();
    }

    if (_counter == 10) {
      showVictoryDisplay();
    }
  }

  void _decrementCounter() {
    setState(() {
      if (_counter == 0) return;
      _counter--;
    });

    if (_counter == 5) {
      showGameOverDisplay();
    }

    if (_counter == 10) {
      showVictoryDisplay();
    }
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });

    showNormalDisplay();
  }

  void showVictoryDisplay() {
    setState(() {
      _message = 'Felicidades, has Ganado!!!';
      _displayedIcon = winIcon;
    });
  }

  void showGameOverDisplay() {
    setState(() {
      _message = 'Has Perdido\n(pista: sigue presionando el botón)';
      _displayedIcon = gameOverIcon;
    });
  }

  void showNormalDisplay() {
    setState(() {
      _message = 'Presiona los botones para jugar';
      _displayedIcon = oIcon;
    });
  }

  Widget footerButton(Function? action, Icon icon) {
    return ElevatedButton(onPressed: () => action!(), child: icon);
  }

  _MyHomePageState() {
    logger.d("constructor, mounted: $mounted");
  }

  @override
  void initState() {
    super.initState();
    logger.d('initState, mounted: $mounted');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.d('didChangeDependencies, mounted: $mounted');
  }

  @override
  void setState(VoidCallback fn) {
    logger.d('setState');
    super.setState(fn);
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    logger.d('didUpdateWidget, mounted: $mounted');
  }

  @override
  void deactivate() {
    super.deactivate();
    logger.d('deactivate, mounted: $mounted');
  }

  @override
  void dispose() {
    super.dispose();
    logger.d('dispose, mounted: $mounted');
  }

  @override
  void reassemble() {
    super.reassemble();
    logger.d('reassemble, mounted: $mounted');
  }

  @override
  Widget build(BuildContext context) {
    logger.d("build method, mounted: $mounted");

    return Scaffold(
      persistentFooterButtons: [
        ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Details()));
            },
            child: const Icon(Icons.details))
      ],
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Card(
          elevation: 50,
          margin: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Child(text: "HOLI"),
              Text(
                _message,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  footerButton(_incrementCounter, const Icon(Icons.add)),
                  footerButton(_decrementCounter, const Icon(Icons.remove)),
                  footerButton(_resetCounter, const Icon(Icons.refresh))
                ],
              )
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _resetCounter,
      //   tooltip: 'Reset',
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }
}
