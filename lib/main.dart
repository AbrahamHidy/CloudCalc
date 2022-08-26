import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_calc/models/calculation.dart';
import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 0, 91, 182),
          secondary: const Color.fromARGB(255, 77, 255, 61),
        ),
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
  Calculation _currentCalculation = Calculation("", "");
  List<Calculation> _sessionCalculations = [];

  void append(String toAppend) {
    setState(() {
      _currentCalculation.appendToExpresstion(toAppend);
    });
  }

  void clearInput() {
    setState(() {
      _currentCalculation.setExpression("");
    });
  }

  void backspace() {
    setState(() {
      _currentCalculation.backspace();
    });
  }

  void solve() {
    setState(() {
      _currentCalculation.solve();
    });
  }

  void saveCurrentCalculation() {
    if (_currentCalculation.getResult().isNotEmpty) {
      setState(() {
        _sessionCalculations.insert(
          0,
          Calculation(
            _currentCalculation.getResult(),
            _currentCalculation.getExpression(),
          ),
        );

        _currentCalculation = Calculation("", "");
      });
    }
  }

  void loadCalculation(int calculationIndex) {
    Calculation calculationToLoad = _sessionCalculations[calculationIndex];
    setState(() {
      _currentCalculation = Calculation(
        calculationToLoad.getResult(),
        calculationToLoad.getExpression(),
      );
    });
  }

  void deleteCalculation(int calculationIndex) {
    setState(() {
      _sessionCalculations.removeAt(calculationIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        toolbarHeight: 35,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: _sessionCalculations.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            onTap: () {
                              loadCalculation(index);
                            },
                            title:
                                Text(_sessionCalculations[index].getResult()),
                            subtitle: Text(
                                _sessionCalculations[index].getExpression()),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => deleteCalculation(index),
                            ),
                          );
                        }),
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    IconButton(
                      onPressed: () => saveCurrentCalculation(),
                      icon: const Icon(
                        Icons.arrow_circle_up_sharp,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: AutoSizeText(
                            _currentCalculation.getResult(),
                            style: const TextStyle(
                              fontSize: 30,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: AutoSizeText(
                            _currentCalculation.getExpression(),
                            style: const TextStyle(
                              fontSize: 30,
                            ),
                            maxLines: 1,
                          ),
                        ),
                        IconButton(
                          onPressed: () => backspace(),
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ButtonBar(
                        children: [
                          ElevatedButton(
                            onPressed: () => clearInput(),
                            child: const Text("CE"),
                          ),
                          ElevatedButton(
                            onPressed: () => append("/"),
                            child: const Text("/"),
                          ),
                          ElevatedButton(
                            onPressed: () => append("*"),
                            child: const Text("*"),
                          ),
                          ElevatedButton(
                            onPressed: () => append("-"),
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
                            onPressed: () => append("7"),
                            child: const Text("7"),
                          ),
                          ElevatedButton(
                            onPressed: () => append("8"),
                            child: const Text("8"),
                          ),
                          ElevatedButton(
                            onPressed: () => append("9"),
                            child: const Text("9"),
                          ),
                          ElevatedButton(
                            onPressed: () => append("+"),
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
                            onPressed: () => append("4"),
                            child: const Text("4"),
                          ),
                          ElevatedButton(
                            onPressed: () => append("5"),
                            child: const Text("5"),
                          ),
                          ElevatedButton(
                            onPressed: () => append("6"),
                            child: const Text("6"),
                          ),
                          ElevatedButton(
                            onPressed: () => append(""),
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
                            onPressed: () => append("1"),
                            child: const Text("1"),
                          ),
                          ElevatedButton(
                            onPressed: () => append("2"),
                            child: const Text("2"),
                          ),
                          ElevatedButton(
                            onPressed: () => append("3"),
                            child: const Text("3"),
                          ),
                          ElevatedButton(
                            onPressed: () => solve(),
                            child: const Text("="),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: "Calculator",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account",
          )
        ],
      ),
    );
  }
}
