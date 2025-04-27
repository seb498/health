import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart'; 

import 'providers/health_provider.dart';


class APIServer {
  final HealthProvider provider;

  APIServer(this.provider);

  void start() async {
    final router = Router();

    // Endpoint to get client profile by ID
    router.get('/client/<id>', (Request request, String id) {
      final client = provider.getClientById(id);
      if (client == null || client.id.isEmpty) {
        return Response.notFound('Client not found');
      }
      return Response.ok(jsonEncode(client.toJson()), headers: {'Content-Type': 'application/json'});
    });

    final handler = const Pipeline()
        .addMiddleware(logRequests())
        .addHandler(router.call);

    final server = await io.serve(handler, 'localhost', 5000);
    print(' API Server running at http://${server.address.host}:${server.port}');
  }
}
