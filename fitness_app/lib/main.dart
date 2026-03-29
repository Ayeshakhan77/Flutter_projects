import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/app_models.dart';
import 'providers/app_providers.dart';
import 'screens/auth_screens.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FitnessTrackerApp());
}

class FitnessTrackerApp extends StatelessWidget {
  const FitnessTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WorkoutProvider()),
        ChangeNotifierProvider(create: (_) => MealProvider()),
        ChangeNotifierProvider(create: (_) => StatsProvider()),
        ChangeNotifierProvider(create: (_) => ChatbotProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return MaterialApp(
            title: 'Fitness Tracker',
            theme: ThemeData(
              brightness: authProvider.isDarkMode ? Brightness.dark : Brightness.light,
              primaryColor: Colors.green.shade700,
              colorScheme: ColorScheme.light(
                primary: Colors.green.shade700,
                secondary: Colors.green.shade300,
                surface: Colors.green.shade50,
                background: Colors.green.shade50,
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              cardTheme: CardThemeData(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.green.shade700, width: 2),
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.green.shade400,
              colorScheme: ColorScheme.dark(
                primary: Colors.green.shade400,
                secondary: Colors.green.shade600,
                surface: Colors.grey.shade900,
                background: Colors.grey.shade900,
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.green.shade900,
                foregroundColor: Colors.white,
              ),
              cardTheme: CardThemeData(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            themeMode: authProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: authProvider.isLoggedIn ? const HomeScreen() : const AuthScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}