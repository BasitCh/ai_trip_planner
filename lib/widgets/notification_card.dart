import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String profileImage;
  final String message;
  final String time;
  final VoidCallback onViewNow;
  final VoidCallback onLater;

  const NotificationCard({
    super.key,
    required this.profileImage,
    required this.message,
    required this.time,
    required this.onViewNow,
    required this.onLater,
  });

  @override
  Widget build(BuildContext context) {
    print("here in card");
    return Material(
        color: Colors.transparent,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(profileImage),
                radius: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: onViewNow,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orangeAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("View Now"),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton(
                              onPressed: onLater,
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("Later"),
                            ),
                          ],
                        ),
                        Text(
                          time,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
