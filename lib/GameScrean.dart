
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
        scoretrack.checkScore();

        return Scaffold(

          body: WillPopScope(
            onWillPop: ()async {
              return false ;
               },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex:2,child: Text("Score : ${scoretrack.Score}")),
                Expanded(
                    flex: 6,
                    child: FutureBuilder(
                      future: getter.getQuizes(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Center(child: CircularProgressIndicator());
                        if (snapshot == null ||
                            getter.quize["Error"] == "connection failed")
                          return Center(
                            child: Text("Connection error"),
                          );
                        String qst = getter.quize["question"].toString();
                        List<Map<String, Object?>> answers =
                        getter.quize["answers"] as List<Map<String, Object?>>;

                        return Column(
                          children: [
                            Container(margin : EdgeInsets.fromLTRB(20, 10, 20, 10) ,color: Theme.of(context).focusColor,alignment: Alignment.center,child: Text(qst)),
                            Container(alignment: Alignment.center,child: Text("Score ${scoretrack.Score}"),),
                            Divider(),
                            Expanded(
                              child: ListView.separated(
                                separatorBuilder: (BuildContext context, int index) =>
                                    Divider(),
                                itemCount: answers.length,
                                itemBuilder: (context, index) {
                                  return Center(
                                    child: ListTile(
                                      textColor: Theme.of(context).colorScheme.primary ,
                                      title: Center(
                                          child: Text(answers[index]["answer"].toString())),
                                      onTap: () async{
                                        if (answers[index]["correct"].toString() ==
                                            "true") {
                                          await scoretrack.UpdateScore();
                                          await getter.getQuizes();
                                        } else {
                                          await scoretrack.ResetScore();
                                          await getter.getQuizes();
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ))
              ],
            ),
          ));
      },
    );
  }
}
