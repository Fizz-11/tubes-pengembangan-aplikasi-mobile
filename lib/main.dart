import 'package:flutter/material.dart';
import 'login_member.dart';
import 'regist_member.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GYMKU',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: const MyHomePage(title: 'GYMKU'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Tambahkan SingleTickerProviderStateMixin untuk animasi
class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    // Inisialisasi controller animasi dengan durasi 800 milidetik
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Mengatur pergerakan dari bawah (dy: 1.0) ke posisi normalnya (dy: 0.0)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic, // Membuat animasi terasa smooth
    ));

    // Memulai animasi saat halaman pertama kali dimuat
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;
            final screenWidth = constraints.maxWidth;

            final imageSize = (screenWidth * 0.5).clamp(120.0, 200.0);
            final topSpacing = screenHeight * 0.08;

            return SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  // Bagian Atas (Logo dan Teks GYMKU)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: topSpacing),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2.0),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/Ellipse 1.png',
                              height: imageSize,
                              width: imageSize,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'GYMKU',
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'PlusJakartaSans',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),

                  // Bagian Bawah (Kotak Welcome dengan Animasi Slide Up)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                        decoration: const BoxDecoration(
                          color: Color(0xFF00BFA5), // Warna hijau tosca sesuai desain
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Mulai perjalanan hidup sehatmu bersama kami. Pantau membership, nikmati fasilitas gym, dan capai target kebugaranmu dengan lebih mudah.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                height: 1.4,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                            const SizedBox(height: 24),
                            
                            // Tombol Login
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(), // Sesuaikan dengan nama class widget di file login_member.dart Anda
                                    ),
                                  );

                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Tombol Registrasi
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const RegisterPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Registrasi',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}