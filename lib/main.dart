import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_app/providers/QuoteProvider.dart';
import 'package:quote_app/ui/DashBoardPage.dart';
import 'package:quote_app/ui/SplashScreenPage.dart';
import 'package:quote_app/utils/Strings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<QuoteProvider>(
          create: (context) => QuoteProvider(),
        ),
      ],
      child: MaterialApp(
        title: Strings.QUOTES,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: SplashScreenPage(),
      ),
    );
  }
}
