import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../data/pet.dart';
import '../../logic/pet_bloc.dart';
import '../../logic/theme_bloc.dart';

class PetCard extends StatelessWidget {
  final Pet pet;

  const PetCard({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine theme state
    final isLightTheme = context.read<ThemeBloc>().state is LightThemeState;

    return GestureDetector(
      onTap: () {
        context.push('/details', extra: pet);
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isLightTheme
                  ? [Colors.blue.shade50, Colors.blue.shade100]
                  : [Colors.grey.shade800, Colors.grey.shade900],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: isLightTheme
                    ? Colors.blue.withOpacity(0.3)
                    : Colors.black.withOpacity(0.6),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              // Pet Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  pet.imageUrl,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              // Pet Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pet.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isLightTheme ? Colors.black87 : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Age: ${pet.age} years',
                      style: TextStyle(
                        color: isLightTheme ? Colors.black54 : Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Price: \$${pet.price}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isLightTheme ? Colors.green : Colors.tealAccent,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
