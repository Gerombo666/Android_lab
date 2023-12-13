import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sun_stickers/states/_states.dart';

import 'ui/_ui.dart';
import 'ui_kit/_ui_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StickerState(),
      child: Builder(
        builder: (context) {
          final light = context.select((StickerState state) => state.light);
          return MaterialApp(
            title: 'Sunny Stickers',
            theme: light ? AppTheme.lightTheme: AppTheme.darkTheme,
            home: const HomeScreen(),
          );
        }
      ),);
  }
}
