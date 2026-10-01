import 'package:flutter/material.dart';
import 'stationery_item.dart';

/// Hanya menampilkan data -> StatelessWidget
class ProfilePage extends StatelessWidget {
  final List<StationeryItem> items;
  const ProfilePage({super.key, required this.items});

  static const String ownerName = 'NATHIQ IZZAN AZIZI';

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF3949AB);
  
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Profil', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            CircleAvatar(
              radius: 44,
              backgroundColor: Colors.indigo.shade100,
              child: const Icon(Icons.person, size: 48, color: blue),
            ),
            const SizedBox(height: 12),
            const Text(ownerName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Pemilik Toko Alat Tulis',
                style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 24),
            const _InfoTile(
              icon: Icons.store,
              title: 'Toko Alat Tulis',
              subtitle: 'Kelola stok dan harga barang dagangan Anda.',
            ),
            _InfoTile(
              icon: Icons.inventory_2,
              title: 'Barang Unggulan',
              subtitle: ' Pulpen, Buku Tulis, dan Pensil',
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _InfoTile(
      {required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.indigo.shade100,
          child: Icon(icon, color: const Color(0xFF3949AB)),
        ),
        title:
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
