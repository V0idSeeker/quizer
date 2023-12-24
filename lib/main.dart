import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizer/GameScrean.dart';
import 'ScoreTrack.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Scoretrack()),
        ],
        builder: (context, widget){
        return  Scaffold(
          body: Center(
              child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image(image: AssetImage("/image.png")),
                ),
              ),
              Expanded(
                child: Center(
                    child: FutureBuilder(
                        future: Provider.of<Scoretrack>(context).checkScore(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return CircularProgressIndicator();
                          if (snapshot.hasError) return Text("Erore");
                          return Text(
                              "Highest score : + ${Provider.of<Scoretrack>(context).Score}");
                        })),
              )
            ],
          )),
          floatingActionButton: MaterialButton(
            color: Colors.blue,
            child: Text("Play"),
            onPressed: () {
              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GameScreen()),
                              );
            },
          ),
        );
        }
    );
    
    }
}
