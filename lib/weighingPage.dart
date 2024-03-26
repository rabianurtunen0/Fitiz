import 'package:flutter/material.dart';

class WeighingPage extends StatefulWidget {
  const WeighingPage({super.key});

  @override
  State<WeighingPage> createState() => _WeighingPageState();
}

class _WeighingPageState extends State<WeighingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(child: Text('Weighing Page'))),
    );
  }
}