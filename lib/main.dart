import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/cat_facts/presentation/bloc/cat_fact_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/di/injection_container.dart';
import 'package:flutter_application_1/features/cat_facts/presentation/pages/cat_fact_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Facts',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) => sl<CatFactBloc>(),
        child: const CatFactPage(),
      ),
    );
  }
}