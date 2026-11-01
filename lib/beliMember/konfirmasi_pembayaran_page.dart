import 'package:flutter/material.dart';
import '../beranda_member.dart'; // Sesuaikan jalur import beranda Anda
import '../scan_wajah_page.dart';

class KonfirmasiPembayaranPage extends StatefulWidget {
  final String packageName;
  final String price;
  final String paymentMethod;

  const KonfirmasiPembayaranPage({
    super.key,
    required this.packageName,
    required this.price,
    this.paymentMethod = 'QRIS',
  });

  @override
  State<KonfirmasiPembayaranPage> createState() => _KonfirmasiPembayaranPageState();
}

class _KonfirmasiPembayaranPageState extends State<KonfirmasiPembayaranPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FBFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Icon Centang Sukses
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF00A896).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  size: 70,
                  color: Color(0xFF00A896),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Pembayaran berhasil',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F1B2B),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Membership Premium kamu sudah aktif. Satu\nlangkah lagi: daftarkan wajahmu.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              
              // Kartu Ringkasan Detail Transaksi
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    _buildDetailRow('Paket', widget.packageName),
                    const SizedBox(height: 12),
                    _buildDetailRow('Metode', widget.paymentMethod),
                    const SizedBox(height: 12),
                    _buildDetailRow('Tanggal', '26 Okt 2026'), // Bisa dibuat dinamis jika perlu
                    const SizedBox(height: 12),
                    _buildDetailRow('ID Transaksi', 'TRX-0142'),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: Colors.black12, height: 1),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total bayar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F1B2B),
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          widget.price,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00A896),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Kotak Info Pendaftaran Wajah
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F2F1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Foto wajah cukup sekali. Setelah itu kamu bisa check-in tanpa kartu.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF00695C),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Tombol "Daftarkan Wajah"
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A896),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => const ScanWajahPage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                        transitionDuration: const Duration(milliseconds: 250),
                      ),
                    );
                  },
                  child: const Text(
                    'Daftarkan wajah',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Tombol "Beranda" (Kembali ke Beranda dan Hapus Riwayat)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF00A896)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => BerandaScreen(userId: 1),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                        transitionDuration: const Duration(milliseconds: 250),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    'Beranda',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00A896),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F1B2B),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}