import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.selectedTheme,
      home: const MainScreen(),
    );
  }
}

// Main Screen
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.purple.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to Flutter!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: themeProvider.selectedFont,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black26,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: themeProvider.selectedTheme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                  shadowColor: Colors.black45,
                ),
                icon: Icon(Icons.settings, color: Colors.white),
                label: const Text(
                  'Go to Settings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Settings Screen
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontFamily: themeProvider.selectedFont),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Choose a Theme:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...ThemeType.values.map(
              (theme) => RadioListTile(
                title: Text(
                  theme.name,
                  style: const TextStyle(fontSize: 16),
                ),
                value: theme,
                groupValue: themeProvider.themeType,
                onChanged: themeProvider.updateTheme,
              ),
            ),
            const Divider(height: 30),
            const Text(
              'Choose a Font:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: themeProvider.selectedFont,
              isExpanded: true,
              items: themeProvider.fonts
                  .map(
                    (font) => DropdownMenuItem(
                      value: font,
                      child: Text(font, style: TextStyle(fontFamily: font)),
                    ),
                  )
                  .toList(),
              onChanged: themeProvider.updateFont,
            ),
          ],
        ),
      ),
    );
  }
}

// Theme Provider
class ThemeProvider extends ChangeNotifier {
  ThemeType _themeType = ThemeType.light;
  String _selectedFont = 'Roboto';

  final List<String> fonts = [
    'Roboto',
    'Lobster',
    'Courier',
    'OpenSans',
    'DancingScript',
    'Poppins',
    'Montserrat',
    'Pacifico',
    'Raleway',
    'Merriweather',
    'Nunito',
    'Oswald',
    'RobotoSlab',
    'Cinzel',
    'AbrilFatface',
    'BebasNeue',
    'PlayfairDisplay',
    'ShadowsIntoLight',
    'SourceSansPro',
  ];

  ThemeType get themeType => _themeType;
  String get selectedFont => _selectedFont;

  ThemeData get selectedTheme {
    switch (_themeType) {
      case ThemeType.dark:
        return ThemeData.dark().copyWith(
          colorScheme: ColorScheme.dark(primary: Colors.grey.shade800),
          textTheme: _getTextTheme(Colors.white),
        );
      case ThemeType.blue:
        return ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.blue.shade50,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
          textTheme: _getTextTheme(Colors.blue.shade900),
        );
      case ThemeType.green:
        return ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.green.shade50,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.green),
          textTheme: _getTextTheme(Colors.green.shade900),
        );
      case ThemeType.purple:
        return ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Colors.purple.shade50,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.purple),
          textTheme: _getTextTheme(Colors.purple.shade900),
        );
      case ThemeType.orange:
        return ThemeData(
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: Colors.orange.shade50,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.orange),
          textTheme: _getTextTheme(Colors.orange.shade900),
        );
      default:
        return ThemeData.light().copyWith(
          textTheme: _getTextTheme(Colors.black),
        );
    }
  }

  void updateTheme(ThemeType? theme) {
    if (theme != null) {
      _themeType = theme;
      notifyListeners();
    }
  }

  void updateFont(String? font) {
    if (font != null) {
      _selectedFont = font;
      notifyListeners();
    }
  }

  TextTheme _getTextTheme(Color color) {
    return TextTheme(
      bodyLarge: TextStyle(color: color, fontFamily: _selectedFont),
      bodyMedium: TextStyle(color: color, fontFamily: _selectedFont),
      titleLarge: TextStyle(color: color, fontFamily: _selectedFont),
    );
  }
}

enum ThemeType { light, dark, blue, green, purple, orange }

// Extension to format theme names
extension ThemeTypeExtension on ThemeType {
  String get name {
    switch (this) {
      case ThemeType.light:
        return 'Light Theme';
      case ThemeType.dark:
        return 'Dark Theme';
      case ThemeType.blue:
        return 'Blue Theme';
      case ThemeType.green:
        return 'Green Theme';
      case ThemeType.purple:
        return 'Purple Theme';
      case ThemeType.orange:
        return 'Orange Theme';
    }
  }
}
