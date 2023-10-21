import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:focus_to_do/presentation/pages/edit_proyect.dart';
import 'package:focus_to_do/presentation/pages/home.dart';
import 'package:focus_to_do/presentation/pages/new_proyect.dart';
import 'package:focus_to_do/presentation/pages/task.dart';
import 'package:focus_to_do/presentation/pages/timer.dart';
import 'package:focus_to_do/presentation/pages/task_list.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus to do',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/task_list': (context) => const TaskListPage(),
        '/timer': (context) => const TimerPage(),
        '/new_proyect': (context) => const NewProyectPage(),
        '/edit_proyect': (context) => const EditProyectPage(),
        '/task': (context) => const TaskPage()
      },
    );
  }
}
