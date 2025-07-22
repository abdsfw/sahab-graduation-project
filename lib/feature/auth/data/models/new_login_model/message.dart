class Message {
  int? id;
  String? name;
  String? image;
  String? phone;
  // String? supplierCode;
  String? status;
  String? role;
  String? email;
  // dynamic emailVerifiedAt;
  // DateTime? createdAt;
  // DateTime? updatedAt;

  Message({
    this.id,
    this.name,
    this.image,
    this.phone,
    // this.supplierCode,
    this.status,
    this.role,
    this.email,
    // this.emailVerifiedAt,
    // this.createdAt,
    // this.updatedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json['id'] as int?,
        name: json['name'] as String?,
        image: json['image'] as String?,
        phone: json['phone'] as String?,
        // supplierCode: json['supplier_code'] as String?,
        status: json['status'] as String?,
        role: json['role'] as String?,
        email: json['email'] as String?,
        // emailVerifiedAt: json['email_verified_at'] as dynamic,
        // createdAt: json['created_at'] == null
        //     ? null
        //     : DateTime.parse(json['created_at'] as String),
        // updatedAt: json['updated_at'] == null
        //     ? null
        //     : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        // 'supplier_code': supplierCode,
        'status': status,
        'role': role,
        'email': email,
        // 'email_verified_at': emailVerifiedAt,
        // 'created_at': createdAt?.toIso8601String(),
        // 'updated_at': updatedAt?.toIso8601String(),
      };
}
