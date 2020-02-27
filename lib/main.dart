import 'package:flutter/material.dart';
import 'package:flutter_firebase_machine_learning_kit/ui/facePage.dart';

void main() => runApp(
      MaterialApp(
        title: 'Flutter Teste',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FacePage(),
      ),
    );
