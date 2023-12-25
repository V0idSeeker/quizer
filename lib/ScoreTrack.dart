import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Scoretrack extends ChangeNotifier {

  late int Score ;
  Map<String, Object?>prefs={};
  Future<void> checkScore() async {
   /* final SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.getInt('counter')==null)await prefs.setInt('score',0);
  Score=int.parse(prefs.getInt('counter').toString());
  */
    Score=0;
    prefs["score"]=Score;
  notifyListeners();
  }

  Future<void> UpdateScore()async {
    Score++;
    print(prefs);
    /*final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('score',Score) ;*/
    prefs["score"]=Score;
    notifyListeners();

  }

  Future<void> ResetScore()async {
    Score=0;

    /*final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('score',Score) ;*/
    prefs["score"]=Score;
    print(prefs);
    notifyListeners();
  }



}