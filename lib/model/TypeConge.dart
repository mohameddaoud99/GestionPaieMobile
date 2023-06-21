
class TypeConge {
  final String libelle;
  final String code;
  final String type;
  TypeConge({
    required this.libelle,
    required this.code,
    required this.type,
  });

  factory TypeConge.fromJson(Map<String, dynamic> json) {
    return TypeConge(
      libelle: json['libelle'],
      code: json['code'],
      type: json['type'],
    );
  }
}