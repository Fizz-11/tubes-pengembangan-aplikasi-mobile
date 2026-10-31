import 'package:flutter/material.dart';
import 'package:gymku/services/membership_service.dart';

import 'package:gymku/beliMember/pilih_paket_page.dart';

class BerandaScreen extends StatefulWidget {
  final int userId;

  const BerandaScreen({super.key, required this.userId});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  // Indeks untuk Bottom Navigation Bar
  int _currentIndex = 0;

  bool isLoading = true;
  bool hasMembership = false;
  String userName = "User";
  String membershipStatus = "-";
  String createdAt = "-";

  @override
  void initState() {
    super.initState();
    loadMembershipData(widget.userId);
  }

  Future<void> loadMembershipData(int id) async {
    final result = await MembershipService.checkMembership(id);

    if (result != null && result['success'] == true) {
      setState(() {
        hasMembership = result['hasMembership'] ?? false;
        userName = result['data']['name'] ?? 'User';
        membershipStatus = result['data']['status'] ?? '-';
        createdAt = result['data']['created_at'] ?? '-';
        isLoading = false;
      });
    } else {
      setState(() {
        hasMembership = false;
        userName = "Tamu";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Daftar halaman yang bisa dipanggil berdasarkan menu bawah
    final List<Widget> pages = [
      _buildHomeBody(), // Halaman Beranda Utama Anda
      _buildPlaceholderPage('Jadwal & Booking Kelas'), // Menu 2
      _buildPlaceholderPage('Riwayat Aktivitas & Streak'), // Menu 3
      _buildProfilePage(), // Menu 4 (Profil)
    ];

    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF0F8A7C)),
            )
          : pages[_currentIndex], // Menampilkan halaman sesuai tab yang dipilih
      // --- BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0F8A7C), // Warna aktif (Tosca)
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department_rounded),
            label: 'Aktivitas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  // --- KONTEN HALAMAN BERANDA UTAMA ANDA ---
  Widget _buildHomeBody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            hasMembership
                ? _buildActiveMembershipCard()
                : _buildNoMembershipCard(),
            const SizedBox(height: 24),
            if (hasMembership) ...[
              _buildQuickMenu(),
              const SizedBox(height: 24),
              _buildWeeklyStreak(),
              const SizedBox(height: 24),
              _buildTodayClasses(),
            ] else ...[
              _buildPopularPackages(),
              const SizedBox(height: 24),
              _buildGymSteps(),
            ],
          ],
        ),
      ),
    );
  }

  // --- HALAMAN SEMENTARA UNTUK MENU LAIN ---
  Widget _buildPlaceholderPage(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  // --- HALAMAN PROFIL SEDERHANA ---
  Widget _buildProfilePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Color(0xFF0F1A2C),
            child: Icon(Icons.person, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            userName,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Status: ${membershipStatus.toUpperCase()}',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // (Widget pendukung lainnya tetap sama seperti sebelumnya: _buildHeader, _buildActiveMembershipCard, dll.)
  Widget _buildHeader() {
    String initials = userName.isNotEmpty
        ? userName
              .trim()
              .split(' ')
              .map((e) => e[0])
              .take(2)
              .join()
              .toUpperCase()
        : 'NB';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: const Color(0xFF0F1A2C),
              child: Text(
                initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'selamat pagi',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F1A2C),
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildActiveMembershipCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F8A7C),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFD4E157),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              membershipStatus.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            userName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'GYM-002145',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.6,
              backgroundColor: Colors.white24,
              color: Colors.white,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status Akun',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  Text(
                    'Terverifikasi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Bergabung Sejak',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  Text(
                    createdAt.split(' ').first,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoMembershipCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1A2C),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF00BFA5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'PREMIUM',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Kamu belum punya\nmembership',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Pilih paket untuk mulai latihan. Tanpa kartu, cukup wajahmu',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4E157),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => const PilihPaketPage(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      // Menggunakan efek Fade (memudar perlahan yang sangat halus)
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 250), // Kecepatan transisi
                  ),
                );
              },
              child: const Text(
                'Beli Membership',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickMenu() {
    final menus = [
      {'icon': Icons.calendar_today_outlined, 'title': 'Riwayat\nKunjungan'},
      {'icon': Icons.assignment_outlined, 'title': 'Booking\nKelas'},
      {'icon': Icons.phonelink_erase_outlined, 'title': 'Bekukan\nMember'},
      {'icon': Icons.receipt_long_outlined, 'title': 'Beli\nPaket'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: menus.map((m) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Icon(
                m['icon'] as IconData,
                size: 28,
                color: const Color(0xFF0F1A2C),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              m['title'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildWeeklyStreak() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Streak Mingguan',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F1A2C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.center_focus_weak,
                      size: 16,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Atur Target',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                  const Text(
                    'Target 4x/minggu',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StreakDay(day: 'Sen', checked: true),
                  _StreakDay(day: 'Sel', checked: false),
                  _StreakDay(day: 'Rab', checked: false),
                  _StreakDay(day: 'Kam', checked: true),
                  _StreakDay(day: 'Jum', checked: false),
                  _StreakDay(day: 'Sab', checked: false, isFailed: true),
                  _StreakDay(day: 'Min', checked: true),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTodayClasses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kelas Hari Ini',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildClassCard(
                '17:00',
                'Yoga Flow',
                'Studio A . Coach Rina',
                '8 slot tersisa',
                const Color(0xFF0F1A2C),
                Colors.white,
              ),
              const SizedBox(width: 12),
              _buildClassCard(
                '19:00',
                'HIIT Burn',
                'Studio B . Coach Dimas',
                '5 slot tersisa',
                Colors.white,
                Colors.black,
                isBordered: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClassCard(
    String time,
    String title,
    String subtitle,
    String slot,
    Color bg,
    Color textCol, {
    bool isBordered = false,
  }) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        border: isBordered ? Border.all(color: Colors.grey.shade300) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isBordered ? const Color(0xFFB2EBF2) : Colors.white24,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              time,
              style: TextStyle(
                color: isBordered ? Colors.teal : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textCol,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: isBordered ? Colors.grey : Colors.white70,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            slot,
            style: TextStyle(
              fontSize: 12,
              color: isBordered ? Colors.grey.shade700 : Colors.white60,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularPackages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Paket Populer',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildPackageCard('1 Bulan', '30 hari', 'Rp 350.000'),
              const SizedBox(width: 12),
              _buildPackageCard('3 Bulan', '90 hari', 'Rp 900.000'),
              const SizedBox(width: 12),
              _buildPackageCard('6 Bulan', '180 hari', 'Rp 1.600.000'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPackageCard(String title, String duration, String price) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            duration,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          Text(
            price,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F8A7C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGymSteps() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cara masuk gym',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildStepItem(
          '1',
          'Beli membership',
          'Pilih paket dan bayar lewat aplikasi',
        ),
        _buildStepItem(
          '2',
          'Daftarkan wajah',
          'Foto sekali, lalu hanya perlu datang',
        ),
        _buildStepItem(
          '3',
          'Dipindai petugas',
          'Petugas memindai wajahmu di pintu masuk',
        ),
      ],
    );
  }

  Widget _buildStepItem(String num, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFF00BFA5),
            child: Text(
              num,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StreakDay extends StatelessWidget {
  final String day;
  final bool checked;
  final bool isFailed;

  const _StreakDay({
    required this.day,
    this.checked = false,
    this.isFailed = false,
  });

  @override
  Widget build(BuildContext context) {
    Color bg = const Color(0xFFE0F2F1);
    Widget icon = const SizedBox.shrink();

    if (checked) {
      bg = const Color(0xFF00BFA5);
      icon = const Icon(Icons.check, color: Colors.white, size: 20);
    } else if (isFailed) {
      bg = const Color(0xFF00BFA5);
      icon = const Icon(Icons.close, color: Colors.white, size: 20);
    }

    return Column(
      children: [
        CircleAvatar(radius: 18, backgroundColor: bg, child: icon),
        const SizedBox(height: 6),
        Text(day, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
