import 'program.dart';

class Client {
  final String id;
  final String name;
  final int age;
  final List<HealthProgram> enrolledPrograms;

  Client({
    required this.id,
    required this.name,
    required this.age,
   List<HealthProgram>? enrolledPrograms, // Make it nullable
}) : enrolledPrograms = enrolledPrograms ?? []; // Default to an empty list if null

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'programs': enrolledPrograms.map((p) => p.toJson()).toList(),
      };
}
