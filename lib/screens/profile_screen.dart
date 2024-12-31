import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock user data
    const String userName = "John Doe";
    const String userEmail = "john.doe@example.com";
    const String userProfilePicUrl =
        "https://www.example.com/profile_pic.jpg"; // Replace with a real image URL or asset

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Anda'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: handle edit profile action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture Section
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: const NetworkImage(userProfilePicUrl),
                // You can use `AssetImage` if you are using local assets
                child: userProfilePicUrl.isEmpty
                    ? const Icon(Icons.person, size: 60)
                    : null,
              ),
            ),
            const SizedBox(height: 20),

            // User Information Section
            const Text(
              userName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              userEmail,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Edit Profile Button
            ElevatedButton(
              onPressed: () {
                // TODO: handle logout
              },
              child: const Text(
                'Keluar',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
