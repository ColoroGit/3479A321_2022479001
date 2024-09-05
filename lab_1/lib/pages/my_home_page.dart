import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String oIcon = 'assets/icons/o_icon.svg';
  String xIcon = 'assets/icons/x_icon.svg';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter == 0) return;
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
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
        footerButton(_incrementCounter, const Icon(Icons.add)),
        footerButton(_decrementCounter, const Icon(Icons.remove))
      ],
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  oIcon,
                  height: 50,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                SvgPicture.asset(
                  xIcon,
                  height: 50,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                )
              ],
            ),
            const Text('Has presionado el botón esta cantidad de veces:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetCounter,
        tooltip: 'Reset',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
