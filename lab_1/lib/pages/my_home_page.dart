import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab_1/models/audit_class.dart';
import 'package:lab_1/models/provider.dart';
import 'package:lab_1/pages/About.dart';
import 'package:lab_1/pages/Audit.dart';
import 'package:lab_1/pages/camera.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab_1/pages/child.dart';
import 'package:lab_1/pages/preferences.dart';
import 'package:lab_1/utils/DatabaseHelper.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'details.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.camera});

  final String title;
  final CameraDescription camera;

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
  DatabaseHelper db = DatabaseHelper.instance;

  var _username = "Usuario";
  var _counter = 0;

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? '';
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  _MyHomePageState() {
    logger.d("constructor, mounted: $mounted");
  }

  @override
  void initState() {
    super.initState();
    logger.d('initState, mounted: $mounted');
    _loadPreferences();
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
                db.create(AuditClass(audit: "Acceso a pantalla About"));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const About()));
              },
            ),
            ListTile(
              title: const Text('Details'),
              onTap: () {
                db.create(AuditClass(audit: "Acceso a pantalla Details"));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Details()));
              },
            ),
            ListTile(
              title: const Text('Audit'),
              onTap: () {
                db.create(AuditClass(audit: "Acceso a pantalla Audit"));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Audit()));
              },
            ),
            ListTile(
              title: const Text('Preferences'),
              onTap: () {
                db.create(AuditClass(audit: "Acceso a pantalla Preferences"));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Preferences())).then((_) {
                  _loadPreferences();
                });
              },
            ),
            ListTile(
              title: const Text('Camera'),
              onTap: () {
                db.create(AuditClass(audit: "Acceso a Camara"));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Camera(camera: widget.camera))).then((_) {
                  _loadPreferences();
                });
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
              Child(text: "Bienvenido $_username"),
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
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        db.create(AuditClass(audit: "Contador Incrementado"));
                        data.incrementCounter;
                      });
                    },
                    child: const Icon(Icons.add),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        db.create(AuditClass(audit: "Contador Decrementado"));
                        data.decrementCounter;
                      });
                    },
                    child: const Icon(Icons.remove),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        db.create(AuditClass(audit: "Contador Reiniciado"));
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
