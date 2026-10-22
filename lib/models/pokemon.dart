class Pokemon {
  final int id;
  final String name;
  final List<String> types;
  final String imageUrl;

  const Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final types = (json['types'] as List)
        .map((t) => t['type']['name'] as String)
        .toList();
    final artwork =
        json['sprites']?['other']?['official-artwork']?['front_default']
            as String?;
    final fallback = json['sprites']?['front_default'] as String?;
    return Pokemon(
      id: json['id'] as int,
      name: json['name'] as String,
      types: types,
      imageUrl: artwork ?? fallback ?? '',
    );
  }
}

String capitalize(String s) =>
    s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);