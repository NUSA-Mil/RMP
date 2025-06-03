import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/features/cat_facts/presentation/bloc/cat_fact_bloc.dart';

class CatFactPage extends StatelessWidget {
  const CatFactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cat Facts')),
      body: Center(
        child: BlocBuilder<CatFactBloc, CatFactState>(
          builder: (context, state) {
            if (state is CatFactInitial) {
              return const Text('Press button to get a cat fact!');
            } else if (state is CatFactLoading) {
              return const CircularProgressIndicator();
            } else if (state is CatFactLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.fact.fact,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text('Length: ${state.fact.length}'),
                  ],
                ),
              );
            } else if (state is CatFactError) {
              return Text(state.message);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CatFactBloc>().add(GetCatFactEvent());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}