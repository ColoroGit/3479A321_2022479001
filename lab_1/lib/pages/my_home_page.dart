import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab_1/models/provider.dart';
import 'package:lab_1/pages/About.dart';
import 'package:lab_1/pages/Audit.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab_1/pages/child.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'details.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  // ignore: no_logic_in_create_state
  State<MyHomePage> createState() {
    var logger = Logger();
    logger.d("create state");
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  var logger = Logger();

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
    final data = Provider.of<AppData>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: Text(
                'Drawer',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                data.addToAudits("Acceso a pantalla About");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const About()));
              },
            ),
            ListTile(
              title: const Text('Details'),
              onTap: () {
                data.addToAudits("Acceso a pantalla Details");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Details()));
              },
            ),
            ListTile(
              title: const Text('Audit'),
              onTap: () {
                data.addToAudits("Acceso a pantalla Audit");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Audit()));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Card(
          elevation: 50,
          margin: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // ignore: prefer_const_constructors
              Child(text: "HOLI"),
              SvgPicture.asset(
                data.displayedIcon,
                height: 75,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              Text(
                data.message,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                '${data.counter}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        data.addToAudits("Contador Incrementado");
                        data.incrementCounter;
                      });
                    },
                    child: const Icon(Icons.add),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        data.decrementCounter;
                        data.addToAudits("Contador Decrementado");
                      });
                    },
                    child: const Icon(Icons.remove),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        data.addToAudits("Contador Reiniciado");
                        data.resetCounter;
                      });
                    },
                    child: const Icon(Icons.refresh),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
