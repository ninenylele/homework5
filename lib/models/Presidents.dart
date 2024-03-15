class President {
  final int id;
  final int ordinal;
  final String name;
  final String yearsInOffice;
  final List<String> vicePresidents;
  final String photo;

  President({
    required this.id,
    required this.ordinal,
    required this.name,
    required this.yearsInOffice,
    required this.vicePresidents,
    required this.photo,
  });

  factory President.fromJson(Map<String, dynamic> json) {
    return President(
      id: json['id'] ?? 0,
      ordinal: json['ordinal'] ?? 0,
      name: json['name'] ?? '',
      yearsInOffice: json['yearsInOffice'] ?? '',
      vicePresidents: List<String>.from(json['vicePresidents'] ?? []),
      photo: json['photo'] ?? '',
    );
  }
}
