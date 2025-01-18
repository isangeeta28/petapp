class Pet {
  final String id;
  final String name;
  final int age;
  final double price;
  final String imageUrl;
  bool isAdopted;

  Pet({
    required this.id,
    required this.name,
    required this.age,
    required this.price,
    required this.imageUrl,
    this.isAdopted = false,
  });

  // Convert Pet to a map for SharedPreferences
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'price': price,
      'imageUrl': imageUrl,
      'isAdopted': isAdopted,
    };
  }

  // Convert map to Pet object
  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      isAdopted: map['isAdopted'],
    );
  }
}
