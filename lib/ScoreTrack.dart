import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Scoretrack extends ChangeNotifier {

  int Score =0;
final file = File('score_data.json');
  Future<void> checkScore() async {

     

  // Create the file if it doesn't exist
  if (!await file.exists()) {
    await file.create(recursive: true);
    await file.writeAsString(jsonEncode({'score': 0}));
  } else {
    
    final jsonData = jsonDecode(await file.readAsString()); 
  }
  final jsonData = jsonDecode(await file.readAsString()); 
  Score=   int.parse( jsonData.toString() );
  notifyListeners();
  }

  Future<void> UpdateScore()async {
    Score++;
    final jsonData = jsonDecode(await file.readAsString());
    jsonData['score'] = Score;

    // Write the updated data back to the file
    await file.writeAsString(jsonEncode(jsonData));
    notifyListeners();
  }

  Future<void> ResetScore()async {
    Score=0;
    final jsonData = jsonDecode(await file.readAsString());
    jsonData['score'] = Score;

    // Write the updated data back to the file
    await file.writeAsString(jsonEncode(jsonData));
    notifyListeners();
  }



}