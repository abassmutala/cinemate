import 'package:cinemate/constants/app_themes.dart';
import 'package:cinemate/constants/credentials.dart';
import 'package:cinemate/constants/ui_constants.dart';
import 'package:cinemate/views/welcome.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cinemate',
      theme: cinemateTheme,
      home: const WelcomeView(),
    );
  }
}
