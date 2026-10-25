import 'package:flutter/material.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  // Flag toggle sementara untuk testing kondisi UI (diubah saat konek PostgreSQL nanti)
  bool hasMembership = true; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Profil & Notifikasi
              _buildHeader(),
              const SizedBox(height: 20),

              // 2. Banner Membership (Kondisional: Aktif vs Belum Aktif)
              hasMembership ? _buildActiveMembershipCard() : _buildNoMembershipCard(),
              const SizedBox(height: 24),

              // 3. Konten Berdasarkan Kondisi Membership
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
      ),
    );
  }

  // --- HEADER USER ---
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: const Color(0xFF0F1A2C),
              child: const Text(
                'NB',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('selamat pagi', style: TextStyle(color: Colors.grey, fontSize: 13)),
                Text(
                  'Naufal Badu',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F1A2C)),
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

  // --- CARD: MEMBER AKTIF (KIRI) ---
  Widget _buildActiveMembershipCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F8A7C), // Warna Hijau Tosca
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFD4E157), // Warna Kuning Lemon
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'PREMIUM',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Naufal Badu',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            'GYM-002145',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Sisa masa aktif', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  Text('142 hari +', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text('Berlaku s.d.', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  Text('5 Jan 2027', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- CARD: BELUM MEMBER (KANAN) ---
  Widget _buildNoMembershipCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1A2C), // Dark Navy/Hitam
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Kamu belum punya\nmembership',
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, height: 1.2),
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {},
              child: const Text('Beli Membership', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  // --- QUICK MENU (RIWAYAT, BOOKING, BEKUKAN, BELI PAKET) ---
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
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
              ),
              child: Icon(m['icon'] as IconData, size: 28, color: const Color(0xFF0F1A2C)),
            ),
            const SizedBox(height: 8),
            Text(
              m['title'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87),
            ),
          ],
        );
      }).toList(),
    );
  }

  // --- STREAK MINGGUAN ---
  Widget _buildWeeklyStreak() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Streak Mingguan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.center_focus_weak, size: 16, color: Colors.white),
                    label: const Text('Atur Target', style: TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                  const Text('Target 4x/minggu', style: TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _StreakDay(day: 'Sen', checked: true),
                  _StreakDay(day: 'Sel', checked: false),
                  _StreakDay(day: 'Rab', checked: false),
                  _StreakDay(day: 'Kam', checked: true),
                  _StreakDay(day: 'Jum', checked: false),
                  _StreakDay(day: 'Sab', checked: false, isFailed: true),
                  _StreakDay(day: 'Min', checked: true),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  // --- KELAS HARI INI ---
  Widget _buildTodayClasses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Kelas Hari Ini', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildClassCard('17:00', 'Yoga Flow', 'Studio A . Coach Rina', '8 slot tersisa', const Color(0xFF0F1A2C), Colors.white),
              const SizedBox(width: 12),
              _buildClassCard('19:00', 'HIIT Burn', 'Studio B . Coach Dimas', '5 slot tersisa', Colors.white, Colors.black, isBordered: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClassCard(String time, String title, String subtitle, String slot, Color bg, Color textCol, {bool isBordered = false}) {
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
            child: Text(time, style: TextStyle(color: isBordered ? Colors.teal : Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textCol)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(fontSize: 12, color: isBordered ? Colors.grey : Colors.white70)),
          const SizedBox(height: 12),
          Text(slot, style: TextStyle(fontSize: 12, color: isBordered ? Colors.grey.shade700 : Colors.white60)),
        ],
      ),
    );
  }

  // --- KONTEN JIKA BELUM MEMBER ---
  Widget _buildPopularPackages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Paket Populer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(duration, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 12),
          Text(price, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F8A7C))),
        ],
      ),
    );
  }

  Widget _buildGymSteps() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Cara masuk gym', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildStepItem('1', 'Beli membership', 'Pilih paket dan bayar lewat aplikasi'),
        _buildStepItem('2', 'Daftarkan wajah', 'Foto sekali, lalu hanya perlu datang'),
        _buildStepItem('3', 'Dipindai petugas', 'Petugas memindai wajahmu di pintu masuk'),
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
            child: Text(num, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Text(desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
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

  const _StreakDay({required this.day, this.checked = false, this.isFailed = false});

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