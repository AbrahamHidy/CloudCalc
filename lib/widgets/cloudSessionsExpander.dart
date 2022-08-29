import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_calc/models/calculation.dart';
import 'package:cloud_calc/widgets/account.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class CloudSessionsExpander extends StatefulWidget {
  const CloudSessionsExpander({Key? key}) : super(key: key);

  @override
  State<CloudSessionsExpander> createState() => _CloudSessionsExpanderState();
}

class _CloudSessionsExpanderState extends State<CloudSessionsExpander> {
  bool _open = false;

  void _expandToggle(bool? open) {
    setState(() {
      _open = open ?? !_open;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _open ? MediaQuery.of(context).size.height - 30 : 50,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(20, 20),
          bottomRight: Radius.elliptical(20, 20),
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
          Account(),
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
