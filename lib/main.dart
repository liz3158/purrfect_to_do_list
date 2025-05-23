import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'screens/home_screen.dart';

//Colors
Color blackColor = const Color(0xff0c120c);
Color blueColor = const Color(0xff4285F4);
Color whiteColor = const Color(0xffFDFDFF);
Color iconColor = const Color(0xff565656);
Color outlineColor = const Color(0xffD6D6D6);
Color descriptionColor = const Color(0xff565656);

// TODO: ADD A .env file
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        title: 'Doable Todo List',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.purple,
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

double verticalPadding(BuildContext context) {
  return MediaQuery.of(context).size.height / 20;
}

double horizontalPadding(BuildContext context) {
  return MediaQuery.of(context).size.width / 20;
}

EdgeInsets textFieldPadding(BuildContext context) {
  // TODO: Convert 25px into respected MediaQuery size
  return EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * 0.1,
      vertical: MediaQuery.of(context).size.height * 0.025);
}

