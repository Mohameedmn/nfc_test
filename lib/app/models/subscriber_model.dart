class Subscriber {
  final int id;
  final String phoneNumber;
  final String status;
  final String language;
  final int activeEsim;

  Subscriber({
    required this.id,
    required this.phoneNumber,
    required this.status,
    required this.language,
    required this.activeEsim,

  });

  factory Subscriber.fromJson(Map<String, dynamic> json) {
    return Subscriber(
      id: json['id'],
      phoneNumber: json['phone_number'],
      status: json['status'],
      language: json['language'],
      activeEsim: json['sim_numbers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone_number': phoneNumber,
      'status': status,
      'language': language,
      'sim_numbers': activeEsim,
      
    };
  }
  static Subscriber empty() => Subscriber(
    id: 0,
    phoneNumber: '',
    status: '',
    language: '',
    activeEsim: 0
  );
}
