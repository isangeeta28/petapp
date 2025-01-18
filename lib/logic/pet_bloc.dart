import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petapp/data/pet_repository.dart';
import '../data/pet.dart';

abstract class PetEvent {}
class LoadPets extends PetEvent {}
class AdoptPet extends PetEvent {
  final String petId;

  AdoptPet(this.petId);
}

abstract class PetState {}
class PetsLoading extends PetState {}
class PetsLoaded extends PetState {
  final List<Pet> pets;

  PetsLoaded(this.pets);
}

class PetBloc extends Bloc<PetEvent, PetState> {
  final PetRepository petRepository;

  PetBloc(this.petRepository) : super(PetsLoading()) {
    on<LoadPets>((event, emit) async {
      try {
        final pets = await petRepository.getPets();
        emit(PetsLoaded(pets));
      } catch (e) {
        emit('Failed to load pets' as PetState);
      }
    });

    on<AdoptPet>((event, emit) async {
      try {
        // Await the Future to get the list of pets
        final pets = await petRepository.getPets();

        // Find the pet in the list by its id
        final pet = pets.firstWhere((p) => p.id == event.petId);

        // Update the pet adoption status
        pet.isAdopted = true;

        // Save the updated adoption status in SharedPreferences
        await petRepository.updatePetAdoptionStatus(pet);

        // Emit the updated list of pets
        emit(PetsLoaded(await petRepository.getPets()));
      } catch (e) {
       // emit(PetsError('Failed to adopt pet: $e'));
        print('Failed to adopt pet: $e');
      }
    });


  }
}
