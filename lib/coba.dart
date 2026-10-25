import 'package:flutter/material.dart';

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
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Transform.translate(
                offset: const Offset(0, -180),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(8.0),
                  child: Image.asset(
                      'assets/images/Ellipse 1.png',
                      height: 200,
                      width: 200,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Transform.translate(
                offset: const Offset(0, -170),
                child:  Text(
                  'GYMKU',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'PlusJakartaSans',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
          ],
        ),
      ),
        
    ),
  );
}
}


