import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String eqn = "0";
  String res = "";
  String exp = "";
  double eqnFont = 50;
  double resFont = 30;
  Color eqnColor = Colors.white;
  Color resColor = Colors.white60;

  buttonPressed(String b) {
    setState(() {
      if (b == "AC" || res != "") {
        if (b == "+" || b == "×" || b == "÷" || b == "-" || b == "%") {
          eqn = res + b;
        } else {
          if (b == "AC")
            eqn = "";
          else
            eqn = b;
        }
        res = "";
        eqnFont = 50;
        resFont = 30;
        eqnColor = Colors.white;
        resColor = Colors.white60;
      } else if (b == "⌫") {
        eqn = eqn.substring(0, eqn.length - 1);
      } else if (b == "=") {
        eqnFont = 30;
        resFont = 50;
        eqnColor = Colors.white60;
        resColor = Colors.white;
        exp = eqn;
        exp = exp.replaceAll('÷', '/');
        exp = exp.replaceAll('×', '*');
        try {
          Parser p = new Parser();
          Expression ex = p.parse(exp);
          ContextModel cm = ContextModel();
          res = '${ex.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          res = " = Error";
        }
      } else {
        if (eqn == "0")
          eqn = b;
        else
          eqn = eqn + b;
      }
    });
  }

  Widget buildButton(String text, double height, Color tColor, Color bColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * height,

      // ignore: deprecated_member_use
      child: RaisedButton(
        color: bColor,
        highlightColor: Colors.deepOrange,
        splashColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressed(text),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 27.0,
            fontWeight: FontWeight.normal,
            color: tColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
        backgroundColor: Colors.black,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black),
      ),
      backgroundColor: Colors.black12,
      body: Column(
        children: <Widget>[
          Expanded(child: Divider()),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              eqn,
              style: TextStyle(fontSize: eqnFont, color: eqnColor),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              res,
              style: TextStyle(fontSize: resFont, color: resColor),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("AC", 1, Colors.deepOrange, Colors.black),
                        buildButton("⌫", 1, Colors.deepOrange, Colors.black),
                        buildButton("÷", 1, Colors.deepOrange, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.white, Colors.black),
                        buildButton("8", 1, Colors.white, Colors.black),
                        buildButton("9", 1, Colors.white, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.white, Colors.black),
                        buildButton("5", 1, Colors.white, Colors.black),
                        buildButton("6", 1, Colors.white, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.white, Colors.black),
                        buildButton("2", 1, Colors.white, Colors.black),
                        buildButton("3", 1, Colors.white, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("%", 1, Colors.white, Colors.black),
                        buildButton("0", 1, Colors.white, Colors.black),
                        buildButton(".", 1, Colors.white, Colors.black),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("×", 1, Colors.deepOrange, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("-", 1, Colors.deepOrange, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("+", 1, Colors.deepOrange, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("=", 2, Colors.white, Colors.deepOrange),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Widget buildButton(String text, double bWeight, Color bColor) {
  //   return Container(
  //
  //   );
  // }
}
