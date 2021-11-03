import 'package:daily_news/src/articles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Articles> _articles = articles;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed((Duration(seconds: 1)));
          setState(() {
            articles.removeAt(0);
          });
        },
        child: ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title: Text(articles[index].title),
                  children: [
                    IconButton(
                        onPressed: () async {
                          if (await canLaunch(articles[index].url)) {
                            launch(articles[index].url);
                          }
                        },
                        icon: Icon(Icons.launch)),
                  ],
                  // subtitle:
                  //
                  // onTap: (){

                  // },
                ),
              );
            }),
      ),
    ));
  }
}
