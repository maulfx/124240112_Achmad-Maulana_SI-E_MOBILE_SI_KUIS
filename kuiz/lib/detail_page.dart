import 'package:flutter/material.dart';
import 'stationery_item.dart';

// Helper function untuk format mata uang Rupiah
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
  // Controller terpisah untuk masing-masing field agar tidak bentrok
  late TextEditingController _descController;
  late TextEditingController _stockController;
  late TextEditingController _priceController;

  // State lokal untuk menyimpan stok dan harga agar perhitungan total langsung reaktif
  late int _stock;
  late int _price;

  @override
  void initState() {
    super.initState();
    // Mengisi nilai awal dari data barang yang diklik
    _stock = widget.stationeryItem.stock;
    _price = widget.stationeryItem.price;

    _descController = TextEditingController(text: widget.stationeryItem.description);
    _stockController = TextEditingController(text: _stock.toString());
    _priceController = TextEditingController(text: _price.toString());
  }

  @override
  void dispose() {
    // Dispose semua controller untuk mencegah memory leak
    _descController.dispose();
    _stockController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Menghitung total nilai stok secara real-time
    final total = _stock * _price;

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
            // Gambar barang
            Image.network(
              widget.stationeryItem.imageUrl,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                height: 220,
                color: Colors.blue.shade100,
                child: const Center(
                  child: Icon(Icons.menu_book, size: 60, color: Colors.blue),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Barang
                  Text(
                    widget.stationeryItem.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Harga per pcs (menyesuaikan input harga secara langsung)
                  Text(
                    '${formatRupiah(_price)} / pcs',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Field 1: Input Ubah Deskripsi
                  TextField(
                    controller: _descController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.description, color: Colors.blue),
                      border: OutlineInputBorder(),
                      labelText: 'Deskripsi',
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Field 2: Input Ubah Stok
                  TextField(
                    controller: _stockController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.inventory, color: Colors.blue),
                      border: OutlineInputBorder(),
                      labelText: 'Stok Tersedia',
                    ),
                    onChanged: (val) {
                      setState(() {
                        _stock = int.tryParse(val) ?? 0;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Field 3: Input Ubah Harga per Pieces
                  TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.monetization_on, color: Colors.blue),
                      border: OutlineInputBorder(),
                      labelText: 'Harga per pcs (Rp)',
                    ),
                    onChanged: (val) {
                      setState(() {
                        _price = int.tryParse(val) ?? 0;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Baris Total Nilai Barang (Stok x Harga)
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

                  // Tombol Simpan Perubahan
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
                      icon: const Icon(Icons.save),
                      label: const Text(
                        'Simpan',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        final newDesc = _descController.text.trim();
                        final newStock = int.tryParse(_stockController.text);
                        final newPrice = int.tryParse(_priceController.text);

                        // Validasi input
                        if (newDesc.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Deskripsi tidak boleh kosong!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        if (newStock == null || newStock < 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Stok harus berupa angka yang valid (>= 0)!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        if (newPrice == null || newPrice < 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Harga harus berupa angka yang valid (>= 0)!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        // Simpan nilai baru ke objek data stationeryItem
                        widget.stationeryItem.description = newDesc;
                        widget.stationeryItem.stock = newStock;
                        widget.stationeryItem.price = newPrice;

                        // Kembali ke halaman sebelumnya dengan membawa status sukses
                        Navigator.pop(context, true);
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
