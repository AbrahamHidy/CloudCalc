import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_calc/models/calculation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class CloudSessionsExpander extends StatefulWidget {
  const CloudSessionsExpander({Key? key}) : super(key: key);

  @override
  State<CloudSessionsExpander> createState() => _CloudSessionsExpanderState();
}

class _CloudSessionsExpanderState extends State<CloudSessionsExpander> {
  bool _open = false;

  final _formKey = GlobalKey<FormState>();

  void _expandToggle(bool? open) {
    setState(() {
      _open = open ?? !_open;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _open ? MediaQuery.of(context).size.height - 30 : 40,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(10, 10),
          bottomRight: Radius.elliptical(10, 10),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black54,
              blurRadius: 15.0,
              offset: Offset(0.0, 0.65))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login"),
                  const SizedBox(height: 30),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Your email",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Choose a password",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 3, 46, 132)),
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                  const SizedBox(height: 60),
                  Row(
                    children: [
                      Text("Need an account?"),
                      TextButton(
                        onPressed: null,
                        child: Text("Get a login"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => _expandToggle(null),
                icon: Icon(_open ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ),
              Row(
                children: [
                  Icon(Icons.cloud_sync),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Unsaved",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: null,
                icon: Icon(Icons.person),
              )
            ],
          ),
        ],
      ),
    );
  }
}
