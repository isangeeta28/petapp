import 'pet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';



class PetRepository {
  Future<List<Pet>> getPets() async {
    final prefs = await SharedPreferences.getInstance();
    // Load pets data from your source (could be local assets or API)
    List<Pet> pets = _loadPetsFromAssetsOrDatabase();

    // Retrieve adoption status from SharedPreferences and update the pets list
    for (var pet in pets) {
      bool isAdopted = prefs.getBool('adopted_${pet.id}') ?? false;
      pet.isAdopted = isAdopted;
    }

    return pets;
  }

  Future<void> updatePetAdoptionStatus(Pet pet) async {
    final prefs = await SharedPreferences.getInstance();
    // Save adoption status to SharedPreferences
    prefs.setBool('adopted_${pet.id}', pet.isAdopted);
  }

  List<Pet> _loadPetsFromAssetsOrDatabase() {
    // This function loads the pet data from your source (e.g., asset files or API)
    // Use your existing logic here
    return  [
      // Dogs
      Pet(
        id: '1',
        name: 'Bella',
        age: 2,
        price: 300,
        imageUrl: 'assets/images/2017-09-26-09-57-33-1100x733.jpg',
      ),
      Pet(
        id: '2',
        name: 'Max',
        age: 3,
        price: 250,
        imageUrl: 'assets/images/dog3-1.jpg',
      ),
      Pet(
        id: '3',
        name: 'Charlie',
        age: 1,
        price: 400,
        imageUrl: 'assets/images/dog-2499023_1280.jpg',
      ),
      // Cats
      Pet(
        id: '4',
        name: 'Luna',
        age: 2,
        price: 150,
        imageUrl: 'assets/images/european-rabbit.jpg',
      ),
      Pet(
        id: '5',
        name: 'Simba',
        age: 4,
        price: 200,
        imageUrl: 'assets/images/Getty-Labrador-Puppy-Whatsapp-Dp-Image-2.jpg',
      ),
      Pet(
        id: '6',
        name: 'Milo',
        age: 1,
        price: 180,
        imageUrl: 'assets/images/green-orange-faced-lovebird-standing-on-the-tree-in-garden-503871724-5c45ad159f4046fda8936dc461f8a607.jpg',
      ),
      // Parrots
      Pet(
        id: '7',
        name: 'Kiwi',
        age: 1,
        price: 100,
        imageUrl: 'assets/images/image-62867-800.jpg',
      ),
      Pet(
        id: '8',
        name: 'Sunny',
        age: 2,
        price: 120,
        imageUrl: 'assets/images/image-85281-800.jpg',
      ),
      Pet(
        id: '9',
        name: 'Coco',
        age: 1,
        price: 130,
        imageUrl: 'assets/images/pexels-photo.jpg',
      ),
      // Rabbits
      Pet(
        id: '10',
        name: 'Thumper',
        age: 1,
        price: 80,
        imageUrl: 'assets/images/pexels-photo-69372.jpeg',
      ),
      Pet(
        id: '11',
        name: 'Snowball',
        age: 2,
        price: 90,
        imageUrl: 'assets/images/rabbit-g9a96f6d1a_1280.jpg',
      ),
      Pet(
        id: '12',
        name: 'Fluffy',
        age: 3,
        price: 95,
        imageUrl: 'assets/images/white-hotot-rabbit-eating-grass-509265984-5c0da06546e0fb0001366ac0.jpg',
      ),
    ];
  }
}
// class PetRepository {
//   Future<List<Pet>> getPets() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? petsData = prefs.getString('pets');
//
//     if (petsData != null) {
//       List<dynamic> petsJson = jsonDecode(petsData);
//       return petsJson.map((pet) => Pet.fromMap(pet)).toList();
//     } else {
//       // If no saved data, return default pets
//       return [
//         // Dogs
//         Pet(
//           id: '1',
//           name: 'Bella',
//           age: 2,
//           price: 300,
//           imageUrl: 'assets/images/2017-09-26-09-57-33-1100x733.jpg',
//         ),
//         Pet(
//           id: '2',
//           name: 'Max',
//           age: 3,
//           price: 250,
//           imageUrl: 'assets/images/dog3-1.jpg',
//         ),
//         Pet(
//           id: '3',
//           name: 'Charlie',
//           age: 1,
//           price: 400,
//           imageUrl: 'assets/images/dog-2499023_1280.jpg',
//         ),
//         // Cats
//         Pet(
//           id: '4',
//           name: 'Luna',
//           age: 2,
//           price: 150,
//           imageUrl: 'assets/images/european-rabbit.jpg',
//         ),
//         Pet(
//           id: '5',
//           name: 'Simba',
//           age: 4,
//           price: 200,
//           imageUrl: 'assets/images/Getty-Labrador-Puppy-Whatsapp-Dp-Image-2.jpg',
//         ),
//         Pet(
//           id: '6',
//           name: 'Milo',
//           age: 1,
//           price: 180,
//           imageUrl: 'assets/images/green-orange-faced-lovebird-standing-on-the-tree-in-garden-503871724-5c45ad159f4046fda8936dc461f8a607.jpg',
//         ),
//         // Parrots
//         Pet(
//           id: '7',
//           name: 'Kiwi',
//           age: 1,
//           price: 100,
//           imageUrl: 'assets/images/image-62867-800.jpg',
//         ),
//         Pet(
//           id: '8',
//           name: 'Sunny',
//           age: 2,
//           price: 120,
//           imageUrl: 'assets/images/image-85281-800.jpg',
//         ),
//         Pet(
//           id: '9',
//           name: 'Coco',
//           age: 1,
//           price: 130,
//           imageUrl: 'assets/images/pexels-photo.jpg',
//         ),
//         // Rabbits
//         Pet(
//           id: '10',
//           name: 'Thumper',
//           age: 1,
//           price: 80,
//           imageUrl: 'assets/images/pexels-photo-69372.jpeg',
//         ),
//         Pet(
//           id: '11',
//           name: 'Snowball',
//           age: 2,
//           price: 90,
//           imageUrl: 'assets/images/rabbit-g9a96f6d1a_1280.jpg',
//         ),
//         Pet(
//           id: '12',
//           name: 'Fluffy',
//           age: 3,
//           price: 95,
//           imageUrl: 'assets/images/white-hotot-rabbit-eating-grass-509265984-5c0da06546e0fb0001366ac0.jpg',
//         ),
//       ];
//     }
//   }
//
//   Future<void> savePets(List<Pet> pets) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String petsJson = jsonEncode(pets.map((pet) => pet.toMap()).toList());
//     await prefs.setString('pets', petsJson);
//   }
// }

// class PetRepository {
//
//
//   List<Pet> getPets() {
//     return [
//       // Dogs
//       Pet(
//         id: '1',
//         name: 'Bella',
//         age: 2,
//         price: 300,
//         imageUrl: 'assets/images/2017-09-26-09-57-33-1100x733.jpg',
//       ),
//       Pet(
//         id: '2',
//         name: 'Max',
//         age: 3,
//         price: 250,
//         imageUrl: 'assets/images/dog3-1.jpg',
//       ),
//       Pet(
//         id: '3',
//         name: 'Charlie',
//         age: 1,
//         price: 400,
//         imageUrl: 'assets/images/dog-2499023_1280.jpg',
//       ),
//       // Cats
//       Pet(
//         id: '4',
//         name: 'Luna',
//         age: 2,
//         price: 150,
//         imageUrl: 'assets/images/european-rabbit.jpg',
//       ),
//       Pet(
//         id: '5',
//         name: 'Simba',
//         age: 4,
//         price: 200,
//         imageUrl: 'assets/images/Getty-Labrador-Puppy-Whatsapp-Dp-Image-2.jpg',
//       ),
//       Pet(
//         id: '6',
//         name: 'Milo',
//         age: 1,
//         price: 180,
//         imageUrl: 'assets/images/green-orange-faced-lovebird-standing-on-the-tree-in-garden-503871724-5c45ad159f4046fda8936dc461f8a607.jpg',
//       ),
//       // Parrots
//       Pet(
//         id: '7',
//         name: 'Kiwi',
//         age: 1,
//         price: 100,
//         imageUrl: 'assets/images/image-62867-800.jpg',
//       ),
//       Pet(
//         id: '8',
//         name: 'Sunny',
//         age: 2,
//         price: 120,
//         imageUrl: 'assets/images/image-85281-800.jpg',
//       ),
//       Pet(
//         id: '9',
//         name: 'Coco',
//         age: 1,
//         price: 130,
//         imageUrl: 'assets/images/pexels-photo.jpg',
//       ),
//       // Rabbits
//       Pet(
//         id: '10',
//         name: 'Thumper',
//         age: 1,
//         price: 80,
//         imageUrl: 'assets/images/pexels-photo-69372.jpeg',
//       ),
//       Pet(
//         id: '11',
//         name: 'Snowball',
//         age: 2,
//         price: 90,
//         imageUrl: 'assets/images/rabbit-g9a96f6d1a_1280.jpg',
//       ),
//       Pet(
//         id: '12',
//         name: 'Fluffy',
//         age: 3,
//         price: 95,
//         imageUrl: 'assets/images/white-hotot-rabbit-eating-grass-509265984-5c0da06546e0fb0001366ac0.jpg',
//       ),
//     ];
//   }
// }
