import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/health_provider.dart';
import 'add_client_screen.dart';
import 'add_program_screen.dart';
import 'client_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final healthProvider = Provider.of<HealthProvider>(context);
    final clients = _searchQuery.isEmpty
        ? healthProvider.clients
        : healthProvider.searchClients(_searchQuery);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Info System'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search Clients',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: clients.length,
              itemBuilder: (ctx, index) {
                final client = clients[index];
                return ListTile(
                  title: Text(client.name),
                  subtitle: Text('Age: ${client.age}'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ClientProfileScreen(clientId: client.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'add_client',
            label: const Text('Add Client'),
            icon: const Icon(Icons.person_add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddClientScreen()),
              );
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            heroTag: 'add_program',
            label: const Text('Add Program'),
            icon: const Icon(Icons.add_business),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddProgramScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
