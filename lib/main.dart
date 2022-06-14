import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tip_calculator/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip calculator',
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
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controllerAmount = TextEditingController();
  final controllerPercent = TextEditingController();
  double tip = 0;

  Future<double?> getDefaultValues() async {
    final prefs = await SharedPreferences.getInstance();
    final double percent = prefs.getDouble('percent') ?? 15;

    return percent;
  }

  @override
  Widget build(BuildContext context) {
    State2 per = State2();
    getDefaultValues()
        .then((value) => {controllerPercent.text = value.toString()});

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tip calculator',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            final route =
                MaterialPageRoute(builder: (context) => const MyApp2());
            Navigator.push(context, route);
          },
        ),
      ),
      body: Container(
        color: Colors.white70,
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  key: Key("amount"),
                  controller: controllerAmount,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: 'Enter the bill amount',
                    labelText: 'Amount',
                    labelStyle: TextStyle(
                        fontSize: 25,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  key: Key("Tip"),
                  controller: controllerPercent,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'percent',
                    labelStyle: TextStyle(
                        fontSize: 25,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text("Tip to pay\$$tip"),
                TextButton(
                    onPressed: () {
                      setState(() {
                        double amount = double.parse(controllerAmount.text);
                        double percent = double.parse(controllerPercent.text);

                        tip = amount * percent / 100;
                        per.setDefaultValues(percent);
                      });
                    },
                    child: Text("Calculate Tip"),
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.purple,
                        onSurface: Colors.grey))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
