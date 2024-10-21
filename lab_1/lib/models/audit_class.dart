class AuditClass {
  final int? id;
  final String? audit;

  AuditClass({
    this.id,
    this.audit,
  });

  Map<String, Object?> toJson() => {
        "_id": id,
        "audit": audit,
      };

  factory AuditClass.fromJson(Map<String, Object?> json) => AuditClass(
        id: json["_id"] as int?,
        audit: json["audit"] as String,
      );

  AuditClass copy({int? id, String? audit}) => AuditClass(
        id: id ?? this.id,
        audit: audit ?? this.audit,
      );
}
