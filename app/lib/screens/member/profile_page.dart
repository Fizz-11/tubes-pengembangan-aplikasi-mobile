import 'package:flutter/material.dart';
import '../../main.dart';
// import 'package:gymku/edit_profile.dart';
import 'edit_profile.dart';
// import 'package:gymku/riwayat_checkin.dart';
import 'riwayat_checkin.dart';
// import 'package:gymku/ganti_password.dart';
import 'ganti_password.dart';

class ProfilePage extends StatelessWidget {
  final String userName;
  final String membershipStatus;

  const ProfilePage({
    super.key,
    required this.userName,
    required this.membershipStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Judul Halaman
              const Text(
                'Profil',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F1B2B),
                ),
              ),
              const SizedBox(height: 20),

              // Avatar & Nama Pengguna
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A896),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'NB',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F1B2B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4E157),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            membershipStatus.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F1B2B),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'GYM-002145',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 3 Kotak Statistik (Kunjungan, Streak, Sisa Paket)
              Row(
                children: [
                  Expanded(child: _buildStatCard('Kunjungan', '14', 'x')),
                  const SizedBox(width: 12),
                  Expanded(child: _buildStatCard('Streak', '6', 'Hari')),
                  const SizedBox(width: 12),
                  Expanded(child: _buildStatCard('Sisa Paket', '142', 'Hari')),
                ],
              ),
              const SizedBox(height: 24),

              // Daftar Menu Pengaturan & Riwayat
              _buildProfileMenuItem(
                icon: Icons.person_outline_rounded,
                iconColor: const Color(0xFF00A896),
                iconBg: const Color(0xFFE0F2F1),
                title: 'Data Diri',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  EditProfilePage(
                        initialName: 'Naufal Badu S.Kom, M.Kom',
                        initialEmail: 'Naufal@gmail.com',
                        initialPhone: '+62 831-7079-6020',
                      ),
                    ),
                  );
                },
              ),
              _buildProfileMenuItem(
                icon: Icons.credit_card_rounded,
                iconColor: const Color(0xFF00A896),
                iconBg: const Color(0xFFE0F2F1),
                title: 'Riwayat Pembayaran',
                onTap: () {
                },
              ),
              _buildProfileMenuItem(
                icon: Icons.history_rounded,
                iconColor: const Color(0xFF00A896),
                iconBg: const Color(0xFFE0F2F1),
                title: 'Riwayat Check-in',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RiwayatCheckinPage(),
                    ),
                  );
                },
              ),
              _buildProfileMenuItem(
                icon: Icons.lock_outline_rounded,
                iconColor: const Color(0xFF00A896),
                iconBg: const Color(0xFFE0F2F1),
                title: 'Ganti Password',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GantiPasswordPage(),
                    ),
                  );
                },
              ),
              _buildProfileMenuItem(
                icon: Icons.logout_rounded,
                iconColor: Colors.redAccent,
                iconBg: const Color(0xFFFFEBEE),
                title: 'Keluar Akun',
                textColor: Colors.redAccent,
                onTap: () {
                  // Menggunakan pushAndRemoveUntil agar semua riwayat halaman terhapus total
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => const MyHomePage(title: 'GYMKU'),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOutCubic;

                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 300),
                    ),
                    (route) => false, // Menghapus seluruh halaman sebelumnya (profil, beranda, dll)
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Helper untuk Kotak Statistik
  Widget _buildStatCard(String label, String value, String unit) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F1B2B)),
              ),
              const SizedBox(width: 2),
              Text(
                unit,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget Helper untuk Item Menu List
Widget _buildProfileMenuItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    Color textColor = const Color(0xFF0F1B2B),
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Material( // <-- Pastikan widget Material ada di sini!
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
          onTap: onTap,
        ),
      ),
    );
  }
}