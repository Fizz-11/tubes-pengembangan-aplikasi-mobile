import 'package:flutter/material.dart';

class PaketMembershipPage extends StatefulWidget {
  const PaketMembershipPage({super.key});

  @override
  State<PaketMembershipPage> createState() => _PaketMembershipPageState();
}

class _PaketMembershipPageState extends State<PaketMembershipPage> {
  // Indeks paket yang dipilih (Default: 1 untuk pilihan "3 Bulan" sesuai gambar)
  int _selectedIndex = 1;

  final List<Map<String, String>> _packages = [
    {'title': '1 Bulan', 'duration': '30 hari', 'price': 'Rp 350.000'},
    {'title': '3 Bulan', 'duration': '90 hari', 'price': 'Rp 900.000'},
    {'title': '6 Bulan', 'duration': '180 hari', 'price': 'Rp 1.700.000'},
    {'title': '1 Tahun', 'duration': '365 hari', 'price': 'Rp 3.299.000'},
  ];

  @override
  Widget build(BuildContext context) {
    final selectedPackage = _packages[_selectedIndex];

    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul Halaman
              const Center(
                child: Text(
                  'Paket Membership',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F1B2B),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Kartu Status Member Aktif (Hijau Toska)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00A896), Color(0xFF028090)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00A896).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Premium',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4FF81),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'AKTIF',
                            style: TextStyle(
                              color: Color(0xFF0F1B2B),
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: 142 / 180, // Progress sisa hari
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFF4FF81)),
                        minHeight: 6,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '142 dari 180 hari tersisa',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Kartu Detail Informasi Member (Mulai, Berakhir, Akses, ID)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildDetailRow('Mulai', '05 Juli 2026'),
                    const Divider(height: 1, color: Color(0xFFEEEEEE)),
                    _buildDetailRow('Berakhir', '05 Jan 2027'),
                    const Divider(height: 1, color: Color(0xFFEEEEEE)),
                    _buildDetailRow('Akses', 'Semua Kelas'),
                    const Divider(height: 1, color: Color(0xFFEEEEEE)),
                    _buildDetailRow('ID Member', 'GYM-002145'),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Judul Bagian Perpanjang Paket
              const Text(
                'Perpanjang Paket',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F1B2B),
                ),
              ),
              const SizedBox(height: 12),

              // Daftar Pilihan Paket Perpanjangan
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Mengikuti scroll utama
                itemCount: _packages.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final pkg = _packages[index];
                  bool isSelected = _selectedIndex == index;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200), // Animasi perubahan pilihan yang halus
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF00A896) : Colors.grey.shade200,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isSelected 
                              ? const Color(0xFF00A896).withOpacity(0.08) 
                              : Colors.black.withOpacity(0.02),
                          blurRadius: isSelected ? 10 : 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                                      color: Color(0xFF0F1B2B),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    pkg['duration']!,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                pkg['price']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00A896),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // Tombol Aksi Perpanjang
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A896),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Memproses perpanjangan ${selectedPackage['title']}...')),
                    );
                  },
                  child: Text(
                    'Perpanjang ${selectedPackage['title']}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  // Widget Helper untuk Baris Detail Informasi
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F1B2B),
            ),
          ),
        ],
      ),
    );
  }
}