import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_calc/models/calculation.dart';
import 'package:cloud_calc/widgets/cloudSessionsExpander.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud Calc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 255, 255, 255),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
  final List<Calculation> _sessionCalculations = [];

  final ButtonStyle _numberButtonStyle =
      ElevatedButton.styleFrom(primary: Colors.green);
  final ButtonStyle _functionButtonStyle =
      ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 98, 93, 86));
  final ButtonStyle _accentButtonStyle =
      ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 3, 46, 132));

  void append(String toAppend) {
    String newChars = "";
    if (toAppend == "(" &&
        _currentCalculation.getExpression().isNotEmpty &&
        "0123456789)"
            .contains(_currentCalculation.getExpression().characters.last)) {
      newChars += "*$toAppend";
    } else {
      newChars = toAppend;
    }

    setState(() {
      _currentCalculation.appendToExpresstion(newChars);
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
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(
                  height: 24,
                ),
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
                              return Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: ListTile(
                                  onTap: () {
                                    loadCalculation(index);
                                  },
                                  title: Text(
                                      _sessionCalculations[index].getResult()),
                                  subtitle: Text(_sessionCalculations[index]
                                      .getExpression()),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Color.fromARGB(255, 183, 26, 26),
                                    ),
                                    onPressed: () => deleteCalculation(index),
                                  ),
                                ),
                              );
                            }),
                          ),
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
                                style: _accentButtonStyle,
                                child: const Text("CE"),
                              ),
                              ElevatedButton(
                                onPressed: () => append("/"),
                                style: _functionButtonStyle,
                                child: const Text("/"),
                              ),
                              ElevatedButton(
                                onPressed: () => append("*"),
                                style: _functionButtonStyle,
                                child: const Text("*"),
                              ),
                              ElevatedButton(
                                onPressed: () => append("-"),
                                style: _functionButtonStyle,
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
                                style: _numberButtonStyle,
                                child: const Text("7"),
                              ),
                              ElevatedButton(
                                onPressed: () => append("8"),
                                style: _numberButtonStyle,
                                child: const Text("8"),
                              ),
                              ElevatedButton(
                                onPressed: () => append("9"),
                                style: _numberButtonStyle,
                                child: const Text("9"),
                              ),
                              ElevatedButton(
                                onPressed: () => append("+"),
                                style: _functionButtonStyle,
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
                                style: _numberButtonStyle,
                                child: const Text("4"),
                              ),
                              ElevatedButton(
                                onPressed: () => append("5"),
                                style: _numberButtonStyle,
                                child: const Text("5"),
                              ),
                              ElevatedButton(
                                onPressed: () => append("6"),
                                style: _numberButtonStyle,
                                child: const Text("6"),
                              ),
                              ElevatedButton(
                                onPressed: () => append(")"),
                                style: _functionButtonStyle,
                                child: const Text(")"),
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
                                style: _numberButtonStyle,
                                child: const Text("1"),
                              ),
                              ElevatedButton(
                                onPressed: () => append("2"),
                                style: _numberButtonStyle,
                                child: const Text("2"),
                              ),
                              ElevatedButton(
                                onPressed: () => append("3"),
                                style: _numberButtonStyle,
                                child: const Text("3"),
                              ),
                              ElevatedButton(
                                onPressed: () => append("("),
                                style: _functionButtonStyle,
                                child: const Text("("),
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
                                onPressed: () => append("0"),
                                style: _numberButtonStyle,
                                child: const Text("0"),
                              ),
                              ElevatedButton(
                                onPressed: () => append("."),
                                style: _numberButtonStyle,
                                child: const Text("."),
                              ),
                              ElevatedButton(
                                onPressed: () => append("^"),
                                style: _functionButtonStyle,
                                child: const Text("^"),
                              ),
                              ElevatedButton(
                                onPressed: () => solve(),
                                style: _accentButtonStyle,
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
          const CloudSessionsExpander(),
        ],
      ),
    );
  }
}
