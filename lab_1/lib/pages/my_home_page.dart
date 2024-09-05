import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'details.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _message = 'Presiona los botones para jugar';
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

  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    logger.d("Logger is working in My Home Page!");

    return Scaffold(
      persistentFooterButtons: [
        ElevatedButton(
            onPressed: () {
              Navigator.push(context,
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
          elevation: 20,
          margin: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SvgPicture.asset(
                _displayedIcon,
                height: 75,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
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
