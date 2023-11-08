import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sun_stickers/states/_states.dart';

import 'ui/_ui.dart';
import 'ui_kit/_ui_kit.dart';

void main() {
  Bloc.observer = const AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SharedBloc>(
      create: (context) => SharedBloc(),
      child: Builder(
        builder: (context) {
          final isLight = context.select((SharedBloc b) => b.state.isLight);
          return MaterialApp(
            title: 'Sunny Stickers',
            theme: isLight ? AppTheme.lightTheme: AppTheme.darkTheme,
            home: const HomeScreen(),
          );
        }
      ),
    );
  }
}


class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();
  ///We can run something, when we create our Bloc
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    ///We can check, if the BlocBase is a Bloc or a Cubit
    if (bloc is Cubit) {
      debugPrint("BlocObserver >> Создан Cubit");
    } else {
      debugPrint("BlocObserver >> Создан Bloc");
    }
  }

  ///We can react to events
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint("BlocObserver >> Улетело событие $event");
  }

  ///We can even react to transitions
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    /// With this we can specifically know, when and what changed in our Bloc
    debugPrint("BlocObserver >> Запускаем перерисовку экранов");
  }

  ///We can react to errors, and we will know the error and the StackTrace
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint("BlocObserver >> Произошла ошибка в блоке $bloc >> $error >> $stackTrace");
  }

  ///We can even run something, when we close our Bloc
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    debugPrint("BLoC is closed");
  }
}


