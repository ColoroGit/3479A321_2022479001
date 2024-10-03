import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Child extends StatefulWidget {
  const Child({
    super.key,
    required this.text,
  });

  final String text;
  @override
  State<Child> createState() {
    var logger = Logger();
    logger.i('create child state');
    return _ChildState();
  }
}

class _ChildState extends State<Child> {
  Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    logger.i('child initState, mounted: $mounted');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.i('child didChangeDependencies, mounted: $mounted');
  }

  @override
  void setState(VoidCallback fn) {
    logger.i('child setState');
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    logger.i('child build method');
    return Column(
      children: <Widget>[
        // text data displayed
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'child: ${widget.text}',
            style: const TextStyle(fontSize: 20),
          ),
        ),
        // Update button
        ElevatedButton(
            onPressed: () {
              setState(() {});
            },
            child: const Text('Update from child')),
      ],
    );
  }

  @override
  void didUpdateWidget(covariant Child oldWidget) {
    super.didUpdateWidget(oldWidget);
    logger.i('child didUpdateWidget, mounted: $mounted');
  }

  @override
  void deactivate() {
    super.deactivate();
    logger.i('child deactivate, mounted: $mounted');
  }

  @override
  void dispose() {
    super.dispose();
    logger.i('child dispose, mounted: $mounted');
  }

  @override
  void reassemble() {
    super.reassemble();
    logger.i('child reassemble, mounted: $mounted');
  }
}
