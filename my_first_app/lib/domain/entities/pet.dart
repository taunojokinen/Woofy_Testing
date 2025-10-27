class Pet {
  final String id;
  final String name;
  final String species; // dog, cat, bird, etc.
  final String breed;
  final int age;
  final String size; // small, medium, large
  final String description;
  final List<String> imageUrls;
  final String ownerId;
  final String? shelterId; // if pet is in shelter
  final bool isAvailableForAdoption;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Pet({
    required this.id,
    required this.name,
    required this.species,
    required this.breed,
    required this.age,
    required this.size,
    required this.description,
    required this.imageUrls,
    required this.ownerId,
    this.shelterId,
    required this.isAvailableForAdoption,
    required this.createdAt,
    required this.updatedAt,
  });

  Pet copyWith({
    String? id,
    String? name,
    String? species,
    String? breed,
    int? age,
    String? size,
    String? description,
    List<String>? imageUrls,
    String? ownerId,
    String? shelterId,
    bool? isAvailableForAdoption,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      species: species ?? this.species,
      breed: breed ?? this.breed,
      age: age ?? this.age,
      size: size ?? this.size,
      description: description ?? this.description,
      imageUrls: imageUrls ?? this.imageUrls,
      ownerId: ownerId ?? this.ownerId,
      shelterId: shelterId ?? this.shelterId,
      isAvailableForAdoption: isAvailableForAdoption ?? this.isAvailableForAdoption,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Pet && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Pet(id: $id, name: $name, species: $species, breed: $breed)';
  }
}