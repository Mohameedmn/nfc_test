class PurchaseRequest {
  final int id;
  final String status;
  final String profileType;
  final int subscriberId; // ✅ FIXED: changed from String to int
  final String createdAt;

  PurchaseRequest({
    required this.id,
    required this.status,
    required this.profileType,
    required this.subscriberId,
    required this.createdAt,
  });

  factory PurchaseRequest.fromJson(Map<String, dynamic> json) {
    return PurchaseRequest(
      id: json['id'],
      status: json['status'],
      profileType: json['profile_type'],
      subscriberId: json['subscriber_id'], // ✅ stays as int
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'profile_type': profileType,
      'subscriber_id': subscriberId,
      'created_at': createdAt,
    };
  }
}
