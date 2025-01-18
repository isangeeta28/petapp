import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petapp/data/pet.dart';

import 'core/app_router.dart';
import 'core/theme.dart';
import 'data/pet_repository.dart';
import 'logic/pet_bloc.dart';
import 'logic/theme_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      child: FutureBuilder<List<Pet>>(
        future: PetRepository().getPets(), // Fetch pets list
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          } else if (snapshot.hasError) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(child: Text('Failed to load pets data')),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(child: Text('No pets available')),
              ),
            );
          } else {
            final pets = snapshot.data!;
            return BlocProvider<PetBloc>(
              create: (context) => PetBloc(PetRepository()), // Pass the PetRepository here
              child: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  return MaterialApp.router(
                    theme: ThemeData.light(),
                    darkTheme: ThemeData.dark(),
                    themeMode: themeState.themeMode,
                    routerConfig: AppRouter().router,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

