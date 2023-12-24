
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ScoreTrack.dart';
import 'Quizgeter.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (create) => Scoretrack()),
        ChangeNotifierProvider(create: (create) => Quizgeter())
      ],
      builder: (context, child) {
        final scoretrack = Provider.of<Scoretrack>(context);
        final getter = Provider.of<Quizgeter>(context);

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Text("Score : ${scoretrack.Score}")),
            Expanded(
                flex: 6,
                child: FutureBuilder(
                  future: getter.getQuizes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return CircularProgressIndicator();
                    if (snapshot == null ||
                        snapshot.data?["Error"] == "connection failed")
                      return Center(
                        child: Text("Connection error"),
                      );
                    String qst = snapshot.data!["question"].toString();
                    List<Map<String, Object?>> answers =
                        snapshot.data!["answers"] as List<Map<String, Object?>>;

                    return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemCount: answers.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Center(
                              child: Text(answers[index]["answer"].toString())),
                          onTap: () {
                            if (answers[index]["correct"].toString() ==
                                "true") {
                              scoretrack.UpdateScore();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GameScreen()),
                              );
                            } else {
                              scoretrack.ResetScore();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GameScreen()),
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                ))
          ],
        );
      },
    );
  }
}
