import 'package:flutter/material.dart';

class Read_Data extends StatefulWidget {
  const Read_Data({super.key});

  @override
  State<Read_Data> createState() => _Read_DataState();
}

class _Read_DataState extends State<Read_Data> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data "),
      ),
    );
  }
}
