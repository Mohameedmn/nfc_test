class IdentityDocument {
  final String firstName;
  final String lastName;
  final int subscribeId;
  final String issuedBy;
  final String issueDate;
  final String expiryDate;
  final String birthDate;
  final String nationality;
  final String gender;
  final int documentNumber;

  IdentityDocument({
    required this.issuedBy,
    required this.issueDate,
    required this.expiryDate,
    required this.birthDate,
    required this.nationality,
    required this.gender,
    required this.documentNumber,
    required this.firstName,
    required this.lastName,
    required this.subscribeId
  });

  factory IdentityDocument.fromJson(Map<String, dynamic> json) {
    return IdentityDocument(
      issuedBy: json['issued_by'] ?? '',
      issueDate: json['issue_date'] ?? '',
      expiryDate: json['expiry_date'] ?? '',
      birthDate: json['birth_date'] ?? '',
      nationality: json['nationality'] ?? '',
      gender: json['gender'] ?? '',
      documentNumber: json['document_number'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      subscribeId: json['subscriber_id'] ?? '',
    );
  }
}
