import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/settings_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc()..add(LoadSettings()),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Настройки',
            theme: state.isDarkTheme ? ThemeData.dark() : ThemeData.light(),
            home: const SettingsScreen(),
          );
        },
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return ListView(
              children: [
                ListTile(
                  title: const Text('Тёмная тема'),
                  trailing: Switch(
                    value: state.isDarkTheme,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(ToggleTheme());
                    },
                  ),
                ),
                const Divider(),
                TextField(
                  controller: TextEditingController(text: state.userName),
                  onChanged: (text) {
                    context.read<SettingsBloc>().add(UpdateName(text));
                  },
                  decoration: const InputDecoration(
                    labelText: 'Ваше имя',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('Показывать подсказки'),
                  trailing: Switch(
                    value: state.showHints,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(ToggleHints());
                    },
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Привет, ${state.userName}!',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}