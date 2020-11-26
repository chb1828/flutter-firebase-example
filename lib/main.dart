import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_and_firebase/models/member.dart';
import 'package:flutter_and_firebase/screens/splash/splash.dart';
import 'package:flutter_and_firebase/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //파이어 베이스 초기화
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Member>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Splash(),
      ),
    );
  }
}

