import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'  as http;

class Quizgeter extends ChangeNotifier{

  late Map<String , Object?> quize ;
Future<void> getQuizes() async{

final response = await http.get(Uri.parse("https://quizapi.io/api/v1/questions?apiKey=vlb39AeHCTh9y380MWjrRaq4oDFEQSo46ASSdsrt"));

if (response.statusCode != 200) quize={"Error" : "connection failed"};
      // If the server returns a 200 OK response, parse the JSON data
        for (var item in  jsonDecode(response.body)) {
    // Extracting question
    String question = item['question'];
    Map<String, Object?> mappedData = {};

    // Extracting potential answers and their correctness
    List<Map<String, String>> answers = [];
    Map<String, Object?> answerData = item['answers'];
    Map<String, Object?> correctAnswers = item['correct_answers'];

    answerData.forEach((key, value) {
      if (value != null) {
        answers.add({
          'answer': value.toString(),
          'correct': (correctAnswers['${key}_correct'] == "true").toString()
        });
      }
    });

    // Creating a map with the question and its answers
    mappedData["question"] = question;
    mappedData["answers"]=answers;
    quize= mappedData ;
  }

    

}



}