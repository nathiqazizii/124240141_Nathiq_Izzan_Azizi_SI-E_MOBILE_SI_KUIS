import 'package:flutter/material.dart';
import 'stationery_item.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  final List<StationeryItem> items;
  final VoidCallback onChanged;

  const HomePage({super.key, required this.items, required this.onChanged});

  Future<void> _openDetail(BuildContext context, StationeryItem item) async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => DetailPage(item: item)),
    );
     if (result != null) {
      item.description = result['description'] as String;
      item.stock = result['stock'] as int;
      item.price = result['price'] as int;
      onChanged();
    }
  }

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF3949AB);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko Alat Tulis',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        itemBuilder: (context, i) {
          final item = items[i];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: InkWell(
              onTap: () => _openDetail(context, item),
              child: SizedBox(
                height: 100,
                child: Row(
                  children: [
                    Hero(
                      tag: item.name,
                      child: Image.network(
                        item.imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 100,
                          color: Colors.indigo.shade100,
                          child: const Icon(Icons.edit, color: blue, size: 36),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            const SizedBox(height: 2),
                            Text(item.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 11, color: Colors.grey.shade600)),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${item.stock} pcs tersedia',
                                    style: const TextStyle(
                                        color: blue,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                                Text('Rp ${item.formattedPrice} / pcs',
                                    style: const TextStyle(
                                        color: Color(0xFF2E7D32),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}