class Logs {
  final int id;
  final String action;
  final String actionType;
  final String ipAddress;
  final int subscriberId;
  final DateTime createdAt;

  Logs({
    required this.id,
    required this.action,
    required this.actionType,
    required this.subscriberId,
    required this.createdAt,
    required this.ipAddress
  });

    factory Logs.fromJson(Map<String, dynamic> json) {
    return Logs(
      id: json['id'],
      action: json['action'],
      actionType: json['actionType'],
      ipAddress: json['ipAddress'],
      subscriberId: json['subscriberId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'action': action,
      'actionType': actionType,
      'ipAddress': ipAddress,
      'subscriberId': subscriberId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
