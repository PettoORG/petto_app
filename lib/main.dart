import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:petto_app/UI/providers/providers.dart';
import 'package:petto_app/config/router/app_router.dart';
import 'package:petto_app/utils/local_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.configPrefs();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ChangeNotifierProvider(create: (context) => ThemeProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ThemeProvider>().loadTheme();
    context.read<LanguageProvider>().loadLanguage();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Petto',
      routerConfig: appRouter,
      theme: context.watch<ThemeProvider>().theme,
      locale: Locale(context.watch<LanguageProvider>().language),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
    );
  }
}
