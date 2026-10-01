import 'package:flutter/material.dart';
import 'stationery_item.dart';

String formatRupiah(int number) {
  return 'Rp ${formatPrice(number)}';
}

class DetailPage extends StatefulWidget {
  final StationeryItem stationeryItem;

  const DetailPage({super.key, required this.stationeryItem});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late int _quantity;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _quantity = widget.stationeryItem.stock;
    _controller = TextEditingController(text: _quantity.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = _quantity * widget.stationeryItem.price;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stationeryItem.name),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.stationeryItem.imageUrl,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                height: 220,
                color: Colors.blue.shade100,
                child: const Center(
                  child: Icon(Icons.fastfood, size: 60, color: Colors.blue),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.stationeryItem.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${formatRupiah(widget.stationeryItem.price)} / pcs',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.stationeryItem.description,
                    style: const TextStyle(color: Colors.grey, height: 1.4),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.menu_book, color: Colors.blue),
                      border: OutlineInputBorder(),
                      labelText: 'deskripsi',
                    ),
                    onChanged: (val) {
                      setState(() {
                        _quantity = int.tryParse(val) ?? 0;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.stationeryItem.description,
                    style: const TextStyle(color: Colors.grey, height: 1.4),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.menu_book, color: Colors.blue),
                      border: OutlineInputBorder(),
                      labelText: 'stok tersedia',
                    ),
                    onChanged: (val) {
                      setState(() {
                        _quantity = int.tryParse(val) ?? 0;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.menu_book, color: Colors.blue),
                      border: OutlineInputBorder(),
                      labelText: 'Harga Barang',
                    ),
                    onChanged: (val) {
                      setState(() {
                        _quantity = int.tryParse(val) ?? 0;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formatRupiah(total),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.shopping_bag),
                      label: const Text(
                        'Simpan',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.pop(context, _quantity);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
