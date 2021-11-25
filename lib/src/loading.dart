import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef LoadingStateBuilder = Widget Function(BuildContext context);

/// Loading state
/// This is the page displayed when the app move to loading state.
// ignore: prefer_function_declarations_over_variables
LoadingStateBuilder sduiLoadingState = (context) => Scaffold(
    appBar: AppBar(
      title: const Text('Loading...',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
      centerTitle: true,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.blueAccent,
    ),
    body: const Center(child: CircularProgressIndicator()));
