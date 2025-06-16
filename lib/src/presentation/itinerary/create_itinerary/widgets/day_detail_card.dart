import 'package:flutter/material.dart';

class DayDetailCard extends StatelessWidget {
  final int dayNumber;
  final String title;
  final String description;
  final List<String> images;
  final VoidCallback onEdit;

  const DayDetailCard({
    required this.dayNumber,
    required this.title,
    required this.description,
    required this.images,
    required this.onEdit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(child: Text(dayNumber.toString())),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: onEdit,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(description),
            SizedBox(height: 8),
            if (images.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: images.map((image) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.network(
                        image,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
