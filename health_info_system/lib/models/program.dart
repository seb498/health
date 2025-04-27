class HealthProgram {
  final String id;
  final String name;

  HealthProgram({required this.id, required this.name});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
