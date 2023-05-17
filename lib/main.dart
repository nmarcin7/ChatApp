import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:new_chat_app/controllers/image_picker_controller.dart';
import 'package:new_chat_app/controllers/theme_controller.dart';
import 'package:new_chat_app/theme/theme.dart';
import 'package:new_chat_app/views/chat_page.dart';
import 'package:new_chat_app/views/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_chat_app/views/register_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => ThemeController(),
      ),
      ChangeNotifierProvider(
        create: (_) => PickingImageController(),
      )
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'registerPage': (context) => RegisterPage(),
        'chatPage': (context) => ChatPage(),
      },
      theme: context.watch<ThemeController>().toggleTheme == false
          ? lightMode
          : darkMode,
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
