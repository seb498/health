import 'package:shelf/shelf.dart'; // For handling HTTP requests
import 'package:shelf/shelf_io.dart' as shelf_io; // To run the server
import 'package:shelf_router/shelf_router.dart'; // To create routes
import 'dart:convert'; // For encoding/decoding JSON

void main() {
  // Create a new Router to define our routes
  final router = Router();

  // Simulated client data (use a persistent storage in real-world cases)
  var clients = [
    {
      'id': '1',
      'name': 'John Doe',
      'age': 30,
      'programs': ['TB', 'Malaria'],
    },
    {
      'id': '2',
      'name': 'Jane Smith',
      'age': 25,
      'programs': ['HIV'],
    }
  ];

  // Simulated program data (you could expand this)
  var programs = ['TB', 'Malaria', 'HIV', 'Diabetes'];

  // Define the basic route for the root path `/`
  router.get('/', (Request request) {
    return Response.ok('Hello, World!');
  });

  // Define the route for fetching the client profile by clientId
  router.get('/client/<clientId>', (Request request, String clientId) {
    // Fetch the client data by clientId
    var client = clients.firstWhere(
      (client) => client['id'] == clientId,
      orElse: () => {},
    );

    // If client is an empty map, return a 404 response
    if (client.isEmpty) {
      return Response.notFound('Client not found');
    }

    // Return the client data as JSON
    return Response.ok(jsonEncode(client),
        headers: {'Content-Type': 'application/json'});
  });

  // Define the route for enrolling a client in a new program
  router.post('/client/enroll', (Request request) async {
    try {
      // 1. Read the incoming request body
      final data = await request.readAsString();

      // 2. Decode the JSON data
      final jsonData = jsonDecode(data);

      // 3. Extract clientId and programId from the request body
      final clientId = jsonData['clientId'];
      final programId = jsonData['programId'];

      // 4. Ensure that the programId is a valid program
      if (!programs.contains(programId)) {
        return Response.badRequest(
          body: 'Invalid program ID.',
          headers: {'Content-Type': 'text/plain'},
        );
      }

      // 5. Find the client by clientId
      var client = clients.firstWhere(
        (client) => client['id'] == clientId,
        orElse: () => {},
      );

      // 6. If client is not found, return a 404 response
      if (client.isEmpty) {
        return Response.notFound('Client not found');
      }

      // 7. Ensure the 'programs' field is a List<String> and add the new program
      if (client['programs'] is List) {
        // Cast the programs to a mutable List<String>
        List<String> programsList = List<String>.from(client['programs'] as List);

        // Add the new program
        programsList.add(programId);

        // 8. Update the client data with the new programs list
        client['programs'] = programsList;
      } else {
        // Return an error response if 'programs' field is not a List
        return Response.internalServerError(
          body: 'Invalid program list format.',
          headers: {'Content-Type': 'text/plain'},
        );
      }

      // 9. Return the updated client data as a JSON response
      return Response.ok(
        jsonEncode(client),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      return Response.internalServerError(
        body: 'Failed to enroll client: $e',
        headers: {'Content-Type': 'text/plain'},
      );
    }
  });

  // Create a handler for the router
  final handler = const Pipeline()
      .addMiddleware(logRequests()) // Optional: log incoming requests to the console
      .addHandler(router);

  // Start the server on localhost at port 8081
  shelf_io.serve(handler, 'localhost', 8082).then((server) {
    print('Server started on http://localhost:8082');
  });
}
