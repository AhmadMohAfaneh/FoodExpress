import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusWaiting extends StatelessWidget {
  const StatusWaiting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text('The waiting page is here sat hello to the',style: TextStyle(fontSize: 20),)),
    );
  }
}
