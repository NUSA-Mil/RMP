import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const SettingsScreen({
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Настройки')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Тема', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SwitchListTile(
              title: Text('Тёмный режим'),
              value: isDarkMode,
              onChanged: onThemeChanged,
            ),
          ],
        ),
      ),
    );
  }
}