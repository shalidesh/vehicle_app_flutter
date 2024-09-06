import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String make = "HONDA";
  String model = "AQUA";
  String transmission = "AUTO";
  String fuel = "ELECTRIC";
  String yom = "2016";
  String engine = "1500";
  List<String> models = [];

  final Map<String, List<String>> manufactureModels = {
    "HONDA": [
      "VEZEL",
      "CIVIC",
      "FIT",
      "GRACE",
      "CR V",
      "HR V",
      "INSIGHT",
      "LH113"
    ],
    "NISSAN": [
      "VANETTE",
      "CARAVAN",
      "BLUEBIRD",
      "TIIDA",
      "SUNNY",
      "X TRAIL",
      "DAYZ"
    ],
    "MICRO": ["ACTYON SPORTS 200XDI"]
  };

  @override
  void initState() {
    super.initState();
    models = manufactureModels[make]!;
    model = models[0];
  }

  void handleSubmit() async {
    final requestBody = {
      "yom": yom,
      "manufacture": make,
      "model": model,
      "engine_capacity": engine,
      "fuel": fuel,
      "transmission": transmission
    };

    try {
      final response = await http.post(
        Uri.parse('http://51.21.1.204/api/predict'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiY2RiIn0.ohLUJ7PZpd7uYR9qqolf1MDXmwt5IYUI5cOKkuTySdw"
        },
        body: jsonEncode(requestBody),
      );

      final data = jsonDecode(response.body);
      print(data);
      final predictedPrice = data['Predicted_Price'];
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Predicted Price: LKR $predictedPrice'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Something went wrong! $error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Center(
        child: Text(
          'Vehicle Form',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Select Manufacture', style: TextStyle(fontSize: 16)),
            DropdownButton<String>(
              value: make,
              onChanged: (String? newValue) {
                setState(() {
                  make = newValue!;
                  models = manufactureModels[make]!;
                  model = models[0];
                });
              },
              items: manufactureModels.keys
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Text('Select Model', style: TextStyle(fontSize: 16)),
            DropdownButton<String>(
              value: model,
              onChanged: (String? newValue) {
                setState(() {
                  model = newValue!;
                });
              },
              items: models.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Text('Select Transmission', style: TextStyle(fontSize: 16)),
            DropdownButton<String>(
              value: transmission,
              onChanged: (String? newValue) {
                setState(() {
                  transmission = newValue!;
                });
              },
              items: <String>['AUTO', 'MANUAL', 'TIPTRONIC']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Text('Select Fuel Type', style: TextStyle(fontSize: 16)),
            DropdownButton<String>(
              value: fuel,
              onChanged: (String? newValue) {
                setState(() {
                  fuel = newValue!;
                });
              },
              items: <String>['PETROL', 'DIESEL', 'HYBRID', 'ELECTRIC']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Year of Manufacture'),
              controller: TextEditingController(text: yom),
              onChanged: (value) {
                setState(() {
                  yom = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Engine Capacity'),
              controller: TextEditingController(text: engine),
              onChanged: (value) {
                setState(() {
                  engine = value;
                });
              },
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Change this to your desired color
                ),
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}
