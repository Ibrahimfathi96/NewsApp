import 'package:flutter/material.dart';
import 'package:news/Core/style/theme.dart';
import 'package:news/Providers/lang_provider.dart';
import 'package:news/View/home/home_page.dart';
import 'package:news/View/news/news_details_screen.dart';
import 'package:news/View/search/search_screen.dart';
import 'package:news/View/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  runApp( ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  late LanguageProvider languageProvider;
  @override
  Widget build(BuildContext context) {
    languageProvider = Provider.of(context);
    getValueFromSharedPreferences();
    return MaterialApp(
      locale: Locale(languageProvider.currentLang),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightPrimary,
      title: 'News App',
      initialRoute:SplashScreen.routeName,
      routes: {
        SplashScreen.routeName : (_)=> SplashScreen(),
        HomePage.routeName : (_)=> HomePage(),
        NewsDetailsScreen.routeName : (_)=> NewsDetailsScreen(),
        SearchPage.routeName : (_)=> SearchPage(),
      },
    );
  }

  getValueFromSharedPreferences() async {
    final pref = await SharedPreferences.getInstance();
    // set lang from sharedPreferences
    languageProvider.getLang(pref.getString('lang') ?? 'ar');
   }
}

