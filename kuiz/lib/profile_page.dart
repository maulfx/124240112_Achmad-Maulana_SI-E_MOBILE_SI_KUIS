import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String userName;

  const ProfilePage({super.key, this.userName = 'BINTORO'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.blue.shade100,
              child: const Icon(Icons.person, size: 50, color: Colors.blue),
            ),
            const SizedBox(height: 12),
            Text(
              userName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Pemilik Toko Alat Tulis',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.restaurant_menu, color: Colors.blue),
                title: const Text(
                  'Toko Alat Tulis',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Kelola Stok dan harga barang dagangan anda.'),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.receipt_long, color: Colors.blue),
                title: const Text(
                  'Barang Unggulan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Pulpen, Buku Tulis, dan Pensil'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
