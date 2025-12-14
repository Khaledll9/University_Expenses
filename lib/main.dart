import 'package:expenses/core/helper_function/on_generate_routes.dart';
import 'package:expenses/core/providers/change_theme_notifier.dart';
import 'package:expenses/core/utils/shared_preferences_singleton.dart';
import 'package:expenses/features/home/presentation/view/home_view.dart';
import 'package:expenses/features/sing_in/presentation/view/sing_in_view.dart';
import 'package:expenses/features/sing_in/presentation/view/widget/waiting_accept_view.dart';
import 'package:expenses/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants.dart';
import 'generated/l10n.dart' show S;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(changeThemeNotifierProvider);
    bool isUserAccepted = Prefs.getBool(kIsUserAccepted);

    bool isSingInPressed = Prefs.getBool(kIsSingInPressed);

    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('ar'),
      theme: themeMode,
      debugShowCheckedModeBanner: false,
      title: 'expenses',
      initialRoute: isUserAccepted
          ? HomeView.routeName
          : isSingInPressed
          ? WaitingAcceptView.routeName
          : SingInView.routeName,
      // home: ShowStudentExpenseView(),
      onGenerateRoute: onGenerateRoute,
    );
  }
}
