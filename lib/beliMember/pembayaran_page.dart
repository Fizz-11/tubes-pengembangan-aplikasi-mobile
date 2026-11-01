import 'package:flutter/material.dart';
import 'package:gymku/beliMember/qris_payment_page.dart';

class PembayaranPage extends StatefulWidget {
  final String packageName; // Contoh: "Premium 3 Bulan"
  final String duration; // Contoh: "90 hari"
  final String price; // Contoh: "Rp 900.000"

  const PembayaranPage({
    super.key,
    required this.packageName,
    required this.duration,
    required this.price,
  });

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  // State untuk menyimpan metode pembayaran yang dipilih
  String selectedPaymentMethod = 'QRIS';

  // State untuk efek hover pada tombol bayar
  bool _isButtonHovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FBFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Pembayaran',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kartu Ringkasan Paket di Atas
            SizedBox(
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F1B2B),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
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
                        'Menunggu pembayaran',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.packageName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${widget.duration} · Akses semua kelas',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Kartu Rincian Harga dengan Drop Shadow
            SizedBox(
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Harga paket',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        Text(
                          widget.price,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Masa aktif',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        Text(
                          widget.duration,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(color: Colors.black12),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total bayar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          widget.price,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF00A896),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Judul Pilih Metode Pembayaran
            const Text(
              'Pilih metode pembayaran',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Opsi Metode Pembayaran (QRIS, Transfer Bank, E-Wallet) dengan Drop Shadow & Efek Pilihan
            _buildPaymentOption(
              title: 'QRIS',
              subtitle: 'Scan dari e-wallet atau m-banking',
              icon: Icons.qr_code_2_rounded,
              value: 'QRIS',
            ),
            const SizedBox(height: 10),
            _buildPaymentOption(
              title: 'Transfer Bank',
              subtitle: 'Bayar lewat virtual account',
              icon: Icons.account_balance_outlined,
              value: 'Transfer Bank',
            ),
            const SizedBox(height: 10),
            _buildPaymentOption(
              title: 'E-Wallet',
              subtitle: 'Bayar lewat aplikasi e-wallet',
              icon: Icons.account_balance_wallet_outlined,
              value: 'E-Wallet',
            ),
            const SizedBox(height: 10),

            // Kartu Kode Promo dengan Drop Shadow
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Punya kode promo?',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Aksi masukkan kode promo
                    },
                    child: const Text(
                      'Masukkan',
                      style: TextStyle(
                        color: Color(0xFF00A896),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Keterangan Bawah
            const Text(
              'Setelah pembayaran berhasil, kamu lanjut mendaftarkan wajah supaya bisa check-in tanpa kartu.',
              style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 30),

            // Tombol Bayar di Bawah dengan Efek Hover Membal (Scale Animation)
            Center(
              child: MouseRegion(
                onEnter: (_) => setState(() => _isButtonHovered = true),
                onExit: (_) => setState(() => _isButtonHovered = false),
                cursor: SystemMouseCursors.click,
                child: AnimatedScale(
                  scale: _isButtonHovered ? 1.03 : 1.0,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOut,
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00A896),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: _isButtonHovered ? 6 : 3,
                        shadowColor: const Color(0xFF00A896).withValues(alpha: 0.15),
                      ),
                      onPressed: () {
                      // Pindah ke halaman Konfirmasi Pembayaran dengan transisi Fade yang mulus
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>  QrisPaymentPage(
                            packageName:widget.packageName, // Sesuaikan data paketnya
                            price: widget.price,           // Sesuaikan harganya
                          ),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 250),
                        ),
                      );
                      },
                      child: Text(
                        'Bayar ${widget.price}',
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

  // Widget Pembantu untuk Opsi Pembayaran dengan Drop Shadow dan Animasi Interaktif
  Widget _buildPaymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
  }) {
    bool isSelected = selectedPaymentMethod == value;
    return InkWell(
      onTap: () {
        setState(() {
          selectedPaymentMethod = value;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF00A896) : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? const Color(0xFF00A896).withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: isSelected ? 8 : 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: const Color(0xFF00A896), size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: value,
              groupValue: selectedPaymentMethod,
              activeColor: const Color(0xFF00A896),
              onChanged: (String? newValue) {
                setState(() {
                  selectedPaymentMethod = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
