class Profile {
  final int id;
  final String commercialName;
  final String description;

  Profile({
    required this.id,
    required this.commercialName,
    required this.description,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      commercialName: json['commercial_name'],
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'commercial_name': commercialName,
      'description': description,
    };
  }
}
