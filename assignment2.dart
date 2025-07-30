import 'package:flutter/material.dart';

void main() => runApp(MathLearningApp());

class MathLearningApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math for Kids',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: MathHomePage(),
    );
  }
}

class MathHomePage extends StatefulWidget {
  @override
  _MathHomePageState createState() => _MathHomePageState();
}

class _MathHomePageState extends State<MathHomePage> {
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();

  String result = '';
  String operationLabel = '';

  void calculate(String op) {
    double? a = double.tryParse(num1Controller.text);
    double? b = double.tryParse(num2Controller.text);

    if (a == null || b == null) {
      setState(() {
        result = 'Please enter valid numbers!';
        operationLabel = '';
      });
      return;
    }

    setState(() {
      switch (op) {
        case '+':
          result = (a + b).toString();
          operationLabel = 'Addition';
          break;
        case '-':
          result = (a - b).toString();
          operationLabel = 'Subtraction';
          break;
        case '×':
          result = (a * b).toString();
          operationLabel = 'Multiplication';
          break;
        case '÷':
          if (b == 0) {
            result = 'Oops! Cannot divide by 0';
          } else {
            result = (a / b).toStringAsFixed(2);
          }
          operationLabel = 'Division';
          break;
      }
    });
  }

  Widget operationButton(String symbol, Color color) {
    return ElevatedButton(
      onPressed: () => calculate(symbol),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        symbol,
        style: TextStyle(fontSize: 30, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[50],
      appBar: AppBar(
        title: Text('Fun Math Learning'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Enter Two Numbers',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: num1Controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Number A',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: num2Controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Number B',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Choose Operation',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  operationButton('+', Colors.redAccent),
                  operationButton('-', Colors.teal),
                  operationButton('×', Colors.blue),
                  operationButton('÷', Colors.purple),
                ],
              ),
              SizedBox(height: 30),
              Card(
                color: Colors.orange.shade100,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        operationLabel.isNotEmpty ? '$operationLabel Result:' : '',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Text(
                        result,
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
