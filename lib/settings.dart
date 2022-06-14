import 'package:flutter/material.dart';
import 'package:tip_calculator/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'settings',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Tip calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => State2();
}

class State2 extends State<MyHomePage> {
  final controllerPercent = TextEditingController();
  double tip = 0;

  void setDefaultValues(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('percent', value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(
          'Tip calculator',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          const Text('Percent'),
          TextFormField(
            controller: controllerPercent,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(hintText: '5%Enter the percent'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                double percent = double.parse(controllerPercent.text);
                //set the percent
                setDefaultValues(percent);
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
            child: const Text('Set the percent'),
          )
        ],
      ),
    ));
  }
}
