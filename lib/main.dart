import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/pages/to_do_page.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('myBox');
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  String apiKey = dotenv.env['API_KEY'] ?? '';
  String appId = dotenv.env['APP_ID'] ?? '';
  String messagingSenderId = dotenv.env['MESSAGE_ID'] ?? '';
  String projectId = dotenv.env['PROJECT_ID'] ?? '';

  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: apiKey,
    appId: appId,
    messagingSenderId: messagingSenderId,
    projectId: projectId,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoPage(),
    );
  }
}
