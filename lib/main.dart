import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/provider/provider.dart';
import 'package:task2/screen/home_screen.dart';
import 'package:task2/utils/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<NewsProvider>(
          create: (context) => NewsProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<ThemeProvider>(context).theme,
      darkTheme: CustomTheme().darkTheme,
      theme: CustomTheme().lightTheme,
      home: const HomeScreen(),
    );
  }
}
