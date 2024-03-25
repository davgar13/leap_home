import 'package:flutter/material.dart';

class IniHome extends StatefulWidget {
  const IniHome({super.key});

  @override
  State<IniHome> createState() => _IniHomeState();
}

class _IniHomeState extends State<IniHome> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('IniHome'),
      ),
    );
  }
}