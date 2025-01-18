import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petapp/ui/widgets/pet_card.dart';
import '../logic/pet_bloc.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: BlocBuilder<PetBloc, PetState>(
        builder: (context, state) {
          if (state is PetsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PetsLoaded) {
            // Filter adopted pets
            final adoptedPets = state.pets.where((pet) => pet.isAdopted).toList();
            return adoptedPets.isNotEmpty
                ? ListView.builder(
              itemCount: adoptedPets.length,
              itemBuilder: (context, index) {
                final pet = adoptedPets[index];
                return PetCard(pet: pet);
              },
            )
                : const Center(child: Text('No adopted pets.'));
          } else {
            return const Center(child: Text('Something went wrong.'));
          }
        },
      ),
    );
  }
}
