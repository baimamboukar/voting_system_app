import 'package:flutter/material.dart';

class OfflineWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Icon(
              Icons.wifi_off,
              color: Colors.black54,
              size: 100.0,
            ),
            Text(
              "NOT INTERNET CONNEXION",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "Please connect check your connectivity",
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
