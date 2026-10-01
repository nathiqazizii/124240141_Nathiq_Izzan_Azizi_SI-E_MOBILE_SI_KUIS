import 'package:flutter/material.dart';
import 'stationery_item.dart';

class DetailPage extends StatefulWidget {
  final StationeryItem item;
  const DetailPage({super.key, required this.item});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final TextEditingController _descC;
  late final TextEditingController _stockC;
  late final TextEditingController _priceC;

  @override
  void initState() {
    super.initState();
    _descC = TextEditingController(text: widget.item.description);
    _stockC = TextEditingController(text: '${widget.item.stock}');
    _priceC = TextEditingController(text: '${widget.item.price}');
  }

  @override
  void dispose() {
    _descC.dispose();
    _stockC.dispose();
    _priceC.dispose();
    super.dispose();
  }

  void _save() {
    final stock = int.tryParse(_stockC.text.trim());
    final price = int.tryParse(_priceC.text.trim());

    if (_descC.text.trim().isEmpty ||
        stock == null ||
        price == null ||
        stock < 0 ||
        price < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Isi semua data dengan benar (angka tidak negatif)')),
      );
      return;
    }

    Navigator.pop(context, {
      'description': _descC.text.trim(),
      'stock': stock,
      'price': price,
    });
  }

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF3949AB);
    final item = widget.item;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Hero(
            tag: item.name,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                item.imageUrl,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 200,
                  color: Colors.indigo.shade100,
                  child: const Icon(Icons.edit, color: blue, size: 60),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Rp ${item.formattedPrice} / pcs',
                  style: const TextStyle(
                      color: Color(0xFF2E7D32), fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descC,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Deskripsi',
              prefixIcon: Icon(Icons.description),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _stockC,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Stok tersedia (pcs)',
              prefixIcon: Icon(Icons.inventory),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _priceC,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Harga (Rp)',
              prefixIcon: Icon(Icons.attach_money),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: blue,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: _save,
            icon: const Icon(Icons.save),
            label: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
