import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/health_provider.dart';
import '../models/program.dart';

class ClientProfileScreen extends StatelessWidget {
  final String clientId;

  const ClientProfileScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    final healthProvider = Provider.of<HealthProvider>(context);
    final client = healthProvider.getClientById(clientId);

    if (client == null || client.id.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Client Not Found')),
        body: const Center(child: Text('No Client Found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${client.name} Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${client.name}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('Age: ${client.age}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            const Text('Enrolled Programs:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: client.enrolledPrograms.length,
                itemBuilder: (ctx, index) {
                  final program = client.enrolledPrograms[index];
                  return ListTile(
                    title: Text(program.name),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _showEnrollProgramDialog(context, healthProvider, clientId),
              child: const Text('Enroll in a New Program'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEnrollProgramDialog(BuildContext context, HealthProvider provider, String clientId) {
    showDialog(
      context: context,
      builder: (ctx) {
        String? selectedProgramId;

        return AlertDialog(
          title: const Text('Select Program'),
          content: DropdownButtonFormField<String>(
            items: provider.programs.map((program) {
              return DropdownMenuItem(
                value: program.id,
                child: Text(program.name),
              );
            }).toList(),
            onChanged: (value) {
              selectedProgramId = value;
            },
            hint: const Text('Choose a program'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedProgramId != null) {
                  provider.enrollClient(clientId, selectedProgramId!);
                  Navigator.of(ctx).pop();
                }
              },
              child: const Text('Enroll'),
            ),
          ],
        );
      },
    );
  }
}
