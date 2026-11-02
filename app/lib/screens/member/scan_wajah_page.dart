import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
// import '../beranda_member.dart';
import 'beranda_member.dart';

class ScanWajahPage extends StatefulWidget {
  const ScanWajahPage({super.key});

  @override
  State<ScanWajahPage> createState() => _ScanWajahPageState();
}

class _ScanWajahPageState extends State<ScanWajahPage> {
  CameraController? _controller;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  // Fungsi untuk menginisialisasi kamera perangkat
  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      //Pilih Indeks Kamera Secara Spesifik:Sesuaikan kode pemilihan kamera di Flutter.Jika di kode Anda menggunakan cameras[0], ubah kodenya agar bisa mendeteksi daftar kamera yang tersedia atau pilih indeks lain jika Iriun terbaca di indeks ke-1 atau berikutnya:Dartfinal cameras = await availableCameras();
      // Gunakan loop atau pastikan memilih indeks yang tepat untuk Iriun Webcam
      final frontCamera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.external,
        orElse: () => cameras.first,
      );

      _controller = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _controller!.initialize();
      if (!mounted) return; // Mencegah proses jika widget sudah ditutup
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      debugPrint("Error kamera: $e");
    }
  }

  @override
void dispose() {
  _controller?.dispose(); // Wajib untuk menghentikan kamera
  super.dispose();        // Panggil super setelahnya
}

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
          'Data Wajah',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Status
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF4FF81).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFD4E157).withValues(alpha: 0.15)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFFCDDC39),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, color: Color(0xFF2E7D32), size: 24),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wajah sudah terdaftar',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF2E7D32)),
                      ),
                      SizedBox(height: 2),
                      Text('Terakhir diperbarui 3 agustus 2026', style: TextStyle(fontSize: 12, color: Colors.black54)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Kotak Pratinjau Kamera Live
            Container(
              width: double.infinity,
              height: 320,
              decoration: BoxDecoration(
                color: const Color(0xFF0F1B2B),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Tampilkan preview kamera jika sudah siap, jika belum tampilkan loading
                    _isCameraInitialized && _controller != null
                        ? CameraPreview(_controller!)
                        : const Center(
                            child: CircularProgressIndicator(color: Color(0xFFCDDC39)),
                          ),
                    
                    // Sudut Bingkai Kamera (Overlay UI)
                    Positioned(top: 24, left: 24, child: _buildCornerBorder(top: true, left: true)),
                    Positioned(top: 24, right: 24, child: _buildCornerBorder(top: true, left: false)),
                    Positioned(bottom: 24, left: 24, child: _buildCornerBorder(top: false, left: true)),
                    Positioned(bottom: 24, right: 24, child: _buildCornerBorder(top: false, left: false)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Informasi Kapan Perlu Scan Ulang
            const Text(
              'Kapan perlu scan ulang?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F1B2B)),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline_rounded, color: Color(0xFF00A896), size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Wajah berubah karena cedera, bengkak, atau luka sehingga Check-in sering gagal',
                    style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.4),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Tombol "Scan ulang wajah"
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F1B2B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
                onPressed: () async {
                    // Navigasi langsung ke Beranda dengan membawa status member aktif (Simulasi)
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => const BerandaScreen(
                          userId: 1, 
                          forceMember: true, // Memaksa tampilan berubah menjadi member aktif (Premium)
                        ),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                        transitionDuration: const Duration(milliseconds: 250),
                      ),
                      (route) => false, // Menghapus riwayat halaman sebelumnya agar tidak bisa kembali ke halaman scan/pembayaran
                    );
                  },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.qr_code_scanner_rounded, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Scan ulang wajah',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCornerBorder({required bool top, required bool left}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          top: top ? const BorderSide(color: Color(0xFFCDDC39), width: 4) : BorderSide.none,
          bottom: !top ? const BorderSide(color: Color(0xFFCDDC39), width: 4) : BorderSide.none,
          left: left ? const BorderSide(color: Color(0xFFCDDC39), width: 4) : BorderSide.none,
          right: !left ? const BorderSide(color: Color(0xFFCDDC39), width: 4) : BorderSide.none,
        ),
        borderRadius: BorderRadius.only(
          topLeft: (top && left) ? const Radius.circular(12) : Radius.zero,
          topRight: (top && !left) ? const Radius.circular(12) : Radius.zero,
          bottomLeft: (!top && left) ? const Radius.circular(12) : Radius.zero,
          bottomRight: (!top && !left) ? const Radius.circular(12) : Radius.zero,
        ),
      ),
    );
  }
}