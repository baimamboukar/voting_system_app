import 'package:flutter/material.dart';
import 'package:Electchain/config/styles.dart';

class FloatingButton extends StatefulWidget {
  @override
  _FloatingButtonState createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => print('Floating Action button pressed'),
      child: Container(
        decoration: BoxStyles.gradientBox,
        child: IconButton(
            icon: Icon(Icons.how_to_vote_rounded),
            onPressed: () => print('How to vote')),
      ),
    );
  }
}
