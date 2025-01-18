import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petapp/logic/pet_bloc.dart';
import 'package:petapp/data/pet_repository.dart';

import '../data/pet.dart';
import '../logic/theme_bloc.dart'; // Assuming your repository exists here

class DetailsPage extends StatefulWidget {
  final Pet pet;

  const DetailsPage({Key? key, required this.pet}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late bool isAdopted;

  @override
  void initState() {
    super.initState();
    isAdopted = widget.pet.isAdopted; // Initialize from the pet object
  }

  @override
  Widget build(BuildContext context) {
    final isLightTheme = context.read<ThemeBloc>().state is LightThemeState;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: isLightTheme ? Colors.white : Colors.white
        ),
        title: Text(widget.pet.name,
          style: TextStyle(
              color: isLightTheme ? Colors.white : Colors.white
          ),),
        backgroundColor: isLightTheme ? Colors.blue.shade700 : Colors.grey.shade900,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isLightTheme
                ? [Colors.blue.shade50, Colors.blue.shade100]
                : [Colors.grey.shade800, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Pet Image with Interactive Viewer
            Stack(
              children: [
                InteractiveViewer(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: Image.asset(
                      widget.pet.imageUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Chip(
                    label: Text(
                      isAdopted ? 'Adopted' : 'Available',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: isAdopted
                        ? Colors.redAccent
                        : Colors.greenAccent.shade400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Pet Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.pet.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isLightTheme ? Colors.black87 : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Age: ${widget.pet.age} years',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isLightTheme ? Colors.black54 : Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Price: \$${widget.pet.price}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isLightTheme ? Colors.green : Colors.tealAccent,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Adopt Button
                  Center(
                    child: ElevatedButton(
                      onPressed: isAdopted
                          ? null
                          : () async {
                        // Mark the pet as adopted
                        setState(() {
                          isAdopted = true;
                          widget.pet.isAdopted = true; // Update local pet state
                        });

                        // Save adopted pet details to the repository or shared preferences
                        await PetRepository().updatePetAdoptionStatus(widget.pet);

                        // Show confirmation message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("You've adopted ${widget.pet.name}!"),
                          ),
                        );

                        // Update the PetBloc so HistoryPage can reflect the adoption
                        context.read<PetBloc>().add(LoadPets());
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        backgroundColor: isAdopted
                            ? Colors.grey
                            : (isLightTheme ? Colors.blue.shade700 : Colors.teal),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        isAdopted ? 'Already Adopted' : 'Adopt Me',
                        style: TextStyle(
                          color: isAdopted
                              ? isLightTheme ? Colors.black45
                              : isLightTheme ?  Colors.white : Colors.white : Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
