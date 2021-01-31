import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              "SETTINGS",
              style: GoogleFonts.yanoneKaffeesatz(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20.0,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                "Modify and customize your settings there",
                style: TextStyle(fontSize: 18.0, color: Colors.black54),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20.0,
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return ListTile(
              title: Text("Theme Mode"),
              subtitle: Text("Dartk Mode"),
              leading: Icon(Icons.lightbulb_outlined),
              trailing: Switch(
                  value: true,
                  onChanged: (value) {
                    value == true
                        ? Get.changeTheme(ThemeData.dark())
                        : Get.changeTheme(ThemeData.light());
                  }),
            );
          }, childCount: 5))
        ],
      ),
    );
  }
}
