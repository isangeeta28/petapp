import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petapp/ui/widgets/pet_card.dart';
import '../data/pet.dart';
import '../logic/pet_bloc.dart';
import '../logic/theme_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // Dispatch the LoadPets event when this page is built
    context.read<PetBloc>().add(LoadPets());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pets'),
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: context.read<ThemeBloc>().state is LightThemeState
                ? LinearGradient(
              colors: [Colors.blue.shade300, Colors.blue.shade900],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
                : LinearGradient(
              colors: [Colors.grey.shade800, Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                decoration: BoxDecoration(
                  color: context.read<ThemeBloc>().state is LightThemeState
                      ? Colors.blue.shade700
                      : Colors.grey.shade900,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Text(
                  'Pet Adoption',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // ListView Items
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.history, color: Colors.white),
                      title: const Text(
                        'History',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onTap: () {
                        context.push("/history");
                      },
                    ),
                    Divider(
                      color: Colors.white.withOpacity(0.5),
                      thickness: 1,
                    ),
                    ListTile(
                      leading: const Icon(Icons.color_lens, color: Colors.white),
                      title: const Text(
                        'Theme',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // ToggleButtons for Theme
                    Center(
                      child: ToggleButtons(
                        isSelected: [
                          context.read<ThemeBloc>().state is LightThemeState,
                          context.read<ThemeBloc>().state is DarkThemeState,
                        ],
                        onPressed: (index) {
                          final themeBloc = BlocProvider.of<ThemeBloc>(context);
                          if (index == 0) {
                            themeBloc.add(SetLightTheme());
                          } else if (index == 1) {
                            themeBloc.add(SetDarkTheme());
                          }
                        },
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.wb_sunny, color: Colors.orange),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.nightlight_round, color: Colors.indigo),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        borderColor: Colors.white,
                        selectedBorderColor: Colors.white,
                        fillColor: Colors.white.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),
              // Footer
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    '© 2025 PetAdopt',
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search pets by name',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
            ),
          ),
          // Pet List
          Expanded(
            child: BlocBuilder<PetBloc, PetState>(
              builder: (context, state) {
                if (state is PetsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PetsLoaded) {
                  // Filter pets based on the search query
                  final pets = state.pets
                      .where((pet) => pet.name.toLowerCase().contains(searchQuery.toLowerCase()))
                      .toList();
                  return pets.isNotEmpty
                      ? ListView.builder(
                    itemCount: pets.length,
                    itemBuilder: (context, index) {
                      final pet = pets[index];
                      return PetCard(pet: pet);
                    },
                  )
                      : const Center(child: Text('No pets found!'));
                } else {
                  return const Center(child: Text('Something went wrong!'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

