import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexa_iq/app_router.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Soterix Nexa IQ',
      routerConfig: AppRouter.router,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF17b2eb)),
        scaffoldBackgroundColor: Color(0xff032531),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF17b2eb),
            foregroundColor: Color(0xFF1f2f34),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 5,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFe2e3e3)),
          bodyMedium: TextStyle(color: Color(0xFFe2e3e3)),
          bodySmall: TextStyle(color: Color(0xFFe2e3e3)),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1f2f34), // AppBar background
          foregroundColor: Colors.white, // text & icon color
          elevation: 4, // shadow
          centerTitle: true, // center the title
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // color of leading/back icons
          ),
        ),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1f2f34), // same as AppBar background
          selectedItemColor: Colors.white, // active item color
          unselectedItemColor: Colors.white70, // inactive item color
          selectedIconTheme: IconThemeData(color: Colors.white, size: 28),
          unselectedIconTheme: IconThemeData(color: Colors.white70, size: 24),
          showUnselectedLabels: true, // show text for inactive items
          elevation: 4, // shadow
          type: BottomNavigationBarType.fixed, // fixed style
          selectedLabelStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
