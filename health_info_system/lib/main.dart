
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/health_provider.dart';
import 'screens/home_screen.dart';
import 'api_server.dart'; // <<< API Server

void main() {
  runApp(const HealthInfoApp());
}
class HealthInfoApp extends StatelessWidget {
  const HealthInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final healthProvider = HealthProvider();
        final apiServer = APIServer(healthProvider);
        apiServer.start(); // <<< START API SERVER
        return healthProvider;
      },

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Health Info System',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
