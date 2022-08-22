import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud Calc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Cloud Calc'),
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
  String calculation = "";
  String result = "";

  void append(String character) {
    setState(() {
      calculation += character;
    });
  }

  void clearInput() {
    setState(() {
      calculation = "";
    });
  }

  void backspace() {
    setState(() {
      if (calculation.length > 1) {
        calculation = calculation.substring(0, calculation.length - 1);
      } else if (calculation.length == 1) {
        calculation = "";
      }
    });
  }

  void solve() {
    String solution;

    if (calculation.isNotEmpty) {
      solution = calculation.interpret().toString();
    } else {
      solution = "";
    }

    setState(() {
      result = solution;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Column(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          result,
                          style: const TextStyle(
                            fontSize: 30,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          calculation,
                          style: const TextStyle(
                            fontSize: 30,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      IconButton(
                        onPressed: () => {
                          backspace(),
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonBar(
                      children: [
                        ElevatedButton(
                          onPressed: () => {
                            clearInput(),
                          },
                          child: const Text("CE"),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            append("/"),
                          },
                          child: const Text("/"),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            append("*"),
                          },
                          child: const Text("*"),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            append("-"),
                          },
                          child: const Text("-"),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonBar(
                      children: [
                        ElevatedButton(
                          onPressed: () => {
                            append("7"),
                          },
                          child: const Text("7"),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            append("8"),
                          },
                          child: const Text("8"),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            append("9"),
                          },
                          child: const Text("9"),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            append("+"),
                          },
                          child: const Text("+"),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonBar(
                      children: [
                        ElevatedButton(
                          onPressed: () => {
                            append("4"),
                          },
                          child: const Text("4"),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            append("5"),
                          },
                          child: const Text("5"),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            append("6"),
                          },
                          child: const Text("6"),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            append(""),
                          },
                          child: const Text("Test"),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonBar(
                      children: [
                        ElevatedButton(
                          onPressed: () => {
                            append("1"),
                          },
                          child: const Text("1"),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            append("2"),
                          },
                          child: const Text("2"),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            append("3"),
                          },
                          child: const Text("3"),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            solve(),
                          },
                          child: const Text("="),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
