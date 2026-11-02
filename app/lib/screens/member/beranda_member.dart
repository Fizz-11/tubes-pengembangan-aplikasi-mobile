import 'package:flutter/material.dart';
import 'package:gymku/services/membership_service.dart';
import 'package:gymku/beliMember/pilih_paket_page.dart';
// import 'package:gymku/profile_page.dart';
import 'profile_page.dart';
// import 'package:gymku/perpanjang_member.dart';
import 'perpanjang_member.dart';
// import 'package:gymku/booking_kelas.dart';
import 'booking_kelas.dart';

class BerandaScreen extends StatefulWidget {
  final int userId;
  final bool forceMember; // Parameter sementara untuk simulasi tanpa database

  const BerandaScreen({
    super.key,
    required this.userId,
    this.forceMember = false,
  });

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  int _currentIndex = 0;

  bool isLoading = true;
  bool hasMembership = false;
  String userName = "User";
  String membershipStatus = "-";
  String createdAt = "-";

  @override
  void initState() {
    super.initState();

    // --- SIMULASI SEMENTARA (TIDAK PERLU MENUNGGU DATABASE) ---
    // Jika dibuka dengan forceMember = true (misal dari halaman scan wajah),
    // maka langsung paksa ubah status jadi member aktif (Premium).
    if (widget.forceMember) {
      setState(() {
        hasMembership = true;
        userName = "Naufal Badu";
        membershipStatus = "Premium";
        createdAt = "2026-06-01";
        isLoading = false;
      });
    } else {
      // Jika dibuka normal, jalankan fungsi cek database asli
      loadMembershipData(widget.userId);
    }
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
        membershipStatus = "-";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeBody(),
      const BookingKelasPage(),
      const PaketMembershipPage(),
      ProfilePage(userName: userName, membershipStatus: membershipStatus),
    ];

    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF0F8A7C)),
            )
          : pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0F8A7C),
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
            label: 'Kelas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_agenda_outlined),
            label: 'Paket',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  // --- KONTEN HALAMAN BERANDA UTAMA ---
  Widget _buildHomeBody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            // Kartu Kondisional (Berubah otomatis berdasarkan status membership)
            hasMembership
                ? _buildActiveMembershipCard()
                : _buildNoMembershipCard(),
            const SizedBox(height: 24),
            if (hasMembership) ...[
              _buildQuickMenuMember(),
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
                Row(
                  children: const [
                    Text(
                      'selamat pagi ',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
                const Text(
                  'User', // Ganti dengan variabel userName jika dinamis
                  style: TextStyle(
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

  // --- KARTU KETIKA SUDAH MEMBER (PREMIUM) ---
  Widget _buildActiveMembershipCard() {
    return Container(
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
            color: const Color(0xFF00A896).withValues(alpha: 0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF4FF81),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              membershipStatus.toUpperCase(),
              style: const TextStyle(
                color: Color(0xFF0F1B2B),
                fontWeight: FontWeight.bold,
                fontSize: 11,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            userName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'GYM-002145',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.75,
              backgroundColor: Colors.white.withValues(alpha: 0.15),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Sisa masa aktif\n142 hari',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 14),
                  ),
                ],
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Berlaku s.d.',
                    style: TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                  Text(
                    '5 Jan 2027',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
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

  // --- KARTU KETIKA BELUM MEMBER ---
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
              color: const Color(0xFFFBB03B),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Tidak Aktif',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const PilihPaketPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                    transitionDuration: const Duration(milliseconds: 250),
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

  // --- MENU PINTASAN KETIKA SUDAH MEMBER (5 MENU) ---
  Widget _buildQuickMenuMember() {
    final menus = [
      {'icon': Icons.event_available_rounded, 'title': 'Riwayat\nCheck-in'},
      {'icon': Icons.edit_calendar_rounded, 'title': 'Booking\nKelas'},
      {'icon': Icons.card_membership_rounded, 'title': 'Beli\nPaket'},
      {'icon': Icons.support_agent_rounded, 'title': 'Customer\nService'},
      {'icon': Icons.pause_circle_outline_rounded, 'title': 'Bekukan\nMember'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: menus.map((m) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                m['icon'] as IconData,
                size: 22,
                color: const Color(0xFF0F1B2B),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              m['title'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF0F1B2B),
                fontWeight: FontWeight.w500,
                height: 1.2,
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
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F1A2C),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.center_focus_weak,
                          color: Colors.white,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Atur Target',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F1A2C),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '17:00',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Yoga Flow',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Studio A . Coach Rina',
                      style: TextStyle(color: Colors.white60, fontSize: 11),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '8 slot tersisa',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F7FA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '19:00',
                        style: TextStyle(
                          color: Color(0xFF00838F),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'HIIT Burn',
                      style: TextStyle(
                        color: Color(0xFF0F1B2B),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Studio B . Coach Dimas',
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '5 slot tersisa',
                      style: TextStyle(
                        color: Color(0xFF0F1B2B),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
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
      icon = const Icon(Icons.check, color: Colors.white, size: 18);
    } else if (isFailed) {
      bg = const Color(0xFF00BFA5);
      icon = const Icon(Icons.close, color: Colors.white, size: 18);
    }

    return Column(
      children: [
        CircleAvatar(radius: 17, backgroundColor: bg, child: icon),
        const SizedBox(height: 6),
        Text(day, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
