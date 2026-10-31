import 'package:flutter/material.dart';

import 'pembayaran_page.dart';

class PilihPaketPage extends StatefulWidget {
  const PilihPaketPage({super.key});

  @override
  State<PilihPaketPage> createState() => _PilihPaketPageState();
}

class _PilihPaketPageState extends State<PilihPaketPage> {
  String selectedPackage = '3 Bulan';
  String selectedPrice = 'Rp 900.000';

  // State untuk efek hover tombol
  bool _isButtonHovered = false;

  final List<Map<String, String>> packages = [
    {'title': '1 Bulan', 'duration': '30 hari', 'price': 'Rp 350.000'},
    {'title': '3 Bulan', 'duration': '90 hari', 'price': 'Rp 900.000'},
    {'title': '6 Bulan', 'duration': '180 hari', 'price': 'Rp 1.700.000'},
    {
      'title': '1 Tahun',
      'duration': '365 hari',
      'price': 'Rp 3.000.000',
      'oldPrice': 'Rp 3.299.000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FBFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Paket Membership',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kartu Informasi Atas\
            SizedBox(
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F1B2B),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBB03B),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Tidak Aktif',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Premium ada membership',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Pilih paket di bawah untuk mulai latihan',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Bagian "Yang kamu dapat"
            SizedBox(
              width: double.infinity,

              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Yang kamu dapat',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Akses semua kelas\n• Check-in cukup dengan wajah, tanpa kartu\n• Target latihan dan streak',
                      style: TextStyle(color: Colors.black87, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Judul Pilih Paket
            const Text(
              'Pilih Paket',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Daftar Pilihan Paket dengan Efek Interaktif
            Column(
              children: packages.map((pkg) {
                bool isSelected = selectedPackage == pkg['title'];
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPackage = pkg['title']!;
                        selectedPrice = pkg['price']!;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF00897B)
                              : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected
                                ? const Color(0xFF00897B).withValues(alpha: 0.2)
                                : Colors.black.withValues(alpha: 0.03),
                            blurRadius: isSelected ? 8 : 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pkg['title']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                pkg['duration']!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                pkg['price']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00897B),
                                ),
                              ),
                              if (pkg.containsKey('oldPrice')) ...[
                                const SizedBox(height: 2),
                                Text(
                                  pkg['oldPrice']!,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),

            // Tombol Beli dengan Efek Hover Membal (Scale Animation)
            Center(
              child: MouseRegion(
                onEnter: (_) => setState(() => _isButtonHovered = true),
                onExit: (_) => setState(() => _isButtonHovered = false),
                cursor: SystemMouseCursors.click,
                child: AnimatedScale(
                  scale: _isButtonHovered
                      ? 1.03
                      : 1.0, // Efek membal membesar saat di-hover
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOut,
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00897B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: _isButtonHovered ? 6 : 2,
                      ),
                      onPressed: () {
                        // Aksi ketika tombol beli diklik
                        // Mengambil durasi hari berdasarkan paket yang dipilih
                        String durationDays = '30 hari';
                        if (selectedPackage == '3 Bulan') {
                          durationDays = '90 hari';
                        }
                        if (selectedPackage == '6 Bulan') {
                          durationDays = '180 hari';
                        }
                        if (selectedPackage == '1 Tahun') {
                          durationDays = '365 hari';
                        }

                        // Pindah ke halaman Pembayaran membawa data dinamis
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => PembayaranPage(
                              packageName: 'Premium $selectedPackage',
                              duration: durationDays,
                              price: selectedPrice,
                            ),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              // Efek Fade memudar perlahan yang halus
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(milliseconds: 250), // Durasi transisi
                          ),
                        );
                      },
                      child: Text(
                        'Beli $selectedPackage',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
