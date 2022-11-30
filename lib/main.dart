import 'package:flutter/material.dart';
import 'package:soap_example/tcCheck.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Tckimliknvigovtr checkGo = Tckimliknvigovtr(dogumYili: "999",Ad:"xxx",Soyad:"yyy",TcNo:"123456789");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                ElevatedButton(onPressed:(){
                  checkGo.getCheck().then((response){
                    print(response);
                  });

                }, child: Text("Doğrula")),
              ],
            )

          ],
        ),
      ),
    );
  }
}
