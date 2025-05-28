class VirtualSim {
  final String imsi;
  final int purchaseRequestId;
  final int profileId;
  final String msisdn; //status

  VirtualSim({
    required this.imsi,
    required this.purchaseRequestId,
    required this.profileId,
    required this.msisdn, 
  });

  factory VirtualSim.fromJson(Map<String, dynamic> json) {
    return VirtualSim(
      imsi: json['IMSI'],
      purchaseRequestId: json['purchase_request_id'],
      profileId: json['profile_id'],
      msisdn: json['MSISDN'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'IMSI': imsi,
      'purchase_request_id': purchaseRequestId,
      'profile_id': profileId,
      'MSISDN': msisdn,
    };
  }
}
