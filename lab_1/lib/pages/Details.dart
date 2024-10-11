import 'package:flutter/material.dart';
// import 'about.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<StatefulWidget> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Details'),
      ),
      body: Center(
        child: Card(
          elevation: 20,
          margin: const EdgeInsets.all(25),
          child: ListTile(
            leading: const Icon(
              Icons.design_services_outlined,
              size: 50,
            ),
            title: Text('Press The Button',
                style: Theme.of(context).textTheme.headlineMedium),
            subtitle: Text(
                'Este juego consta de apretar el botón para llegar al número 10. La idea es NO RENDIRSE cuando llegas al 5 y el juego te dice que perdiste.',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
        ),
      ),
      // persistentFooterButtons: [
      //   ElevatedButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       child: const Icon(Icons.home)),
      //   ElevatedButton(
      //       onPressed: () {
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => const About()));
      //       },
      //       child: const Icon(Icons.security_update_warning))
      // ],
    );
  }
}
