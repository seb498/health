import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/client.dart';
import '../models/program.dart';

class HealthProvider with ChangeNotifier {
  final List<Client> _clients = [];
  final List<HealthProgram> _programs = [];

  List<Client> get clients => _clients;
  List<HealthProgram> get programs => _programs;

  void addProgram(String name) {
    final newProgram = HealthProgram(id: const Uuid().v4(), name: name);
    _programs.add(newProgram);
    notifyListeners();
  }

  void addClient(String name, int age) {
    final newClient = Client(id: const Uuid().v4(), name: name, age: age);
    _clients.add(newClient);
    notifyListeners();
  }

  void enrollClient(String clientId, String programId) {
    final client = _clients.firstWhere((c) => c.id == clientId);
    final program = _programs.firstWhere((p) => p.id == programId);

    // ✅ Prevent duplicate enrollment
    if (!client.enrolledPrograms.any((p) => p.id == programId)) {
      client.enrolledPrograms.add(program);
      notifyListeners();
    }
  }

  Client? getClientById(String id) {
    return _clients.firstWhere(
      (c) => c.id == id,
      orElse: () => Client(id: '', name: '', age: 0),
    );
  }

  List<Client> searchClients(String query) {
    return _clients
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
