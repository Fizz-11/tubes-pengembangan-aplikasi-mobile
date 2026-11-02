import 'package:flutter/material.dart';

class BookingKelasPage extends StatefulWidget {
  const BookingKelasPage({super.key});

  @override
  State<BookingKelasPage> createState() => _BookingKelasPageState();
}

class _BookingKelasPageState extends State<BookingKelasPage> {
  // Indeks tanggal yang dipilih (Default ke Senin 5 / index 0)
  int _selectedDateIndex = 0;
  
  // Indeks kategori filter yang dipilih (Default ke "Semua" / index 0)
  int _selectedFilterIndex = 0;

  // Data dummy tanggal mingguan
  final List<Map<String, String>> _dates = [
    {'day': 'Sen', 'date': '5'},
    {'day': 'Sel', 'date': '6'},
    {'day': 'Rab', 'date': '7'},
    {'day': 'Kam', 'date': '8'},
    {'day': 'Jum', 'date': '9'},
    {'day': 'Sab', 'date': '10'},
  ];

  // Data dummy kategori filter
  final List<String> _filters = ['Semua', 'Yoga', 'HIIT', 'Zumba'];

  // Data dummy daftar kelas
  final List<Map<String, String>> _classList = [
    {
      'time': '07:00',
      'title': 'Morning Yoga',
      'studio': 'Studio A · Coach Rina',
      'slots': '10 slot tersisa',
      'status': 'Booking', // 'Booking', 'Terbooking', 'Penuh'
    },
    {
      'time': '12:00',
      'title': 'Core & Abs',
      'studio': 'Studio B · Coach Dimas',
      'slots': '10 slot tersisa',
      'status': 'Booking',
    },
    {
      'time': '17:00',
      'title': 'Yoga Flow',
      'studio': 'Studio A · Coach Rina',
      'slots': '10 slot tersisa',
      'status': 'Terbooking',
    },
    {
      'time': '19:00',
      'title': 'HIIT Burn',
      'studio': 'Studio B · Coach Dimas',
      'slots': '10 slot tersisa',
      'status': 'Penuh',
    },
    {
      'time': '20:00',
      'title': 'Zumba Night',
      'studio': 'Studio A · Coach Sari',
      'slots': '10 slot tersisa',
      'status': 'Booking',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul Halaman
              const Center(
                child: Text(
                  'Booking Kelas',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F1B2B),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Pemilih Tanggal (Horizontal Scroll)
              SizedBox(
                height: 75,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _dates.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final item = _dates[index];
                    bool isSelected = _selectedDateIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDateIndex = index;
                        });
                      },
                      child: Container(
                        width: 58,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF0F1B2B) : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? Colors.transparent : Colors.grey.shade200,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item['day']!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isSelected ? Colors.white70 : Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['date']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : const Color(0xFF0F1B2B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Filter Kategori (Semua, Yoga, HIIT, Zumba)
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedFilterIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilterIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF0F1B2B) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? Colors.transparent : Colors.grey.shade300,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _filters[index],
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Daftar Kartu Kelas
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _classList.length,
                separatorBuilder: (context, index) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final c = _classList[index];
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Waktu & Detail Kelas
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c['time']?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0F1B2B),
                                  ),
                                ),
                                const Text(
                                  'Wib',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Container(
                              height: 40,
                              width: 1,
                              color: Colors.grey.shade200,
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c['title']?? '',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0F1B2B),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  c['studio']?? '',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  c['slots']?? '',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00A896),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Tombol Status (Booking / Terbooking / Penuh)
                        _buildStatusButton(c['status']?? ''),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Helper untuk Tombol Status Kelas
  Widget _buildStatusButton(String status) {
    Color bgColor;
    Color textColor;
    String label = status;

    if (status == 'Booking') {
      bgColor = const Color(0xFFE0F2F1);
      textColor = const Color(0xFF00A896);
    } else if (status == 'Terbooking') {
      bgColor = const Color(0xFF00A896);
      textColor = Colors.white;
    } else {
      // Penuh
      bgColor = const Color(0xFFEEEEEE);
      textColor = Colors.grey;
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      onPressed: status == 'Penuh' ? null : () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Status kelas: $label')),
        );
      },
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}