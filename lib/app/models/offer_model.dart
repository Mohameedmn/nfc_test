class Offer {
  final int id;
  final String name;
  final double price;
  final int profileid; 
  final String description;

  Offer({
    required this.id,
    required this.name,
    required this.price,
    required this.profileid,
    required this.description
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      profileid: json['profile_id'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'profile_id': profileid,
      'description': description,
    };
  }
}
