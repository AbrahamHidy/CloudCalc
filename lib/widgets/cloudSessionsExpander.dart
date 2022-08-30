import 'dart:html';

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

  double minHeight = 50;
  int maxHeight = window.innerHeight != null ? window.innerHeight! - 30 : 50;
  double height = 50;

  void _expandToggle(bool? open) {
    setState(() {
      _open = open ?? !_open;
      if (_open) {
        height = maxHeight.toDouble();
      } else {
        height = minHeight;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (height + details.delta.dy >= minHeight &&
            height + details.delta.dy <= maxHeight) {
          setState(() {
            height += details.delta.dy;
          });
        }
      },
      onVerticalDragEnd: (details) {
        if (height + minHeight > maxHeight / 2) {
          _expandToggle(true);
        } else {
          _expandToggle(false);
        }
      },
      onVerticalDragStart: (details) {
        _open = false;
      },
      child: Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 30),
        height: height,
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
            Expanded(
              child: _open ? Account() : Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _expandToggle(null),
                  icon:
                      Icon(_open ? Icons.arrow_drop_up : Icons.arrow_drop_down),
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
      ),
    );
  }
}
