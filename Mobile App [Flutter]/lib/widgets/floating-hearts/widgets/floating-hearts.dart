

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/floating-hearts-provider.dart';

class FloatingHeartsWidget extends StatelessWidget {
  FloatingHeartsWidget({
    this.context2
  });
  BuildContext? context2;

  @override
  Widget build(BuildContext context) {
    FloatingHeartsProvider floatingHeartsProvider = context2!.watch<FloatingHeartsProvider>();
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom:20),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            height: size.height*0.8,
            width: size.width*0.2,
            child:  Stack(
              children: floatingHeartsProvider.hearts
            ),
            
          ),
        ),
      ));
  }
}