import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";

  List buttons = [
    'C',
    '(',
    ')',
    '÷',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    Icon(Icons.backspace, color: Colors.green.shade800),
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.green.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (BuildContext context, int index) {
                return customButton(buttons[index]);
              },
            ),
          ))
        ],
      ),
    );
  }

  Widget customButton(dynamic text) {
    return InkWell(
      splashColor: text == "1" ||
              text == "2" ||
              text == "3" ||
              text == "4" ||
              text == "5" ||
              text == "6" ||
              text == "7" ||
              text == "8" ||
              text == "9" ||
              text == "0" ||
              text == "." ||
              text == const Icon(Icons.backspace)
          ? Colors.green.shade200
          : Colors.green.shade300,
      onTap: () {
        setState(() {
          handleButton(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
            color: getColorButton(text),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.1),
                blurRadius: 1,
                spreadRadius: 0.5,
                offset: const Offset(-3, -3),
              )
            ]),
        child: Center(
          child: text is String
              ? Text(
                  text,
                  style: TextStyle(
                    fontSize: 45,
                    color: getColor(text),
                  ),
                )
              : text,
        ),
      ),
    );
  }

  getColor(String text) {
    if (text == "*" ||
        text == "-" ||
        text == "+" ||
        text == "=" ||
        text == "(" ||
        text == ")" ||
        text == "C" ||
        text == "÷") {
      return const Color.fromARGB(255, 255, 255, 255);
    }
    return Colors.green.shade800;
  }

  getColorButton(dynamic text) {
    if (text == "*" ||
        text == "-" ||
        text == "+" ||
        text == "(" ||
        text == ")" ||
        text == "C" ||
        text == "÷") {
      return Colors.green.shade300;
    } else if (text == "=") {
      return Colors.green.shade700;
    }
    return Colors.green.shade100;
  }

  handleButton(dynamic text) {
    if (text == "C") {
      userInput = " ";
      result = "0";
      return;
    }
    if (text is Icon || text == const Icon(Icons.backspace)) {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    }
    if (text == "=") {
      userInput = calculate();
      result = userInput;

      if (userInput.endsWith(".0")){
        
        userInput = userInput.replaceAll(".0", "");

      }
      if (result.endsWith(".0")){
        result = result.replaceAll(".0", "");

      }
      return;
    }
    
    userInput = userInput + text;
  }
  String calculate() {
    try {
        var exp = Parser().parse(userInput);
        var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
        return evaluation.toString();
    } catch (e) {
        return "Error";
    }
}
}
