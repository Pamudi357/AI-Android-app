import 'package:flutter/material.dart';

class VenueDetails extends StatelessWidget {
  const VenueDetails({
    Key? key,
    required this.venueName,
    required this.venueLocation,
    required this.venueDescription,
    required this.images,
  }) : super(key: key);

  final String venueName;
  final String venueLocation;
  final String venueDescription;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(venueName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display images
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.network(images[index]),
                  );
                },
              ),
            ),
            // Venue location
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Location: $venueLocation',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // Venue description
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Description: $venueDescription',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            // Request quote button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle request quote button tap
                  // You can navigate to another screen or perform other actions here
                },
                child: const Text('Request Quote'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
