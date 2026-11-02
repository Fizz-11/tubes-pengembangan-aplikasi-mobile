import 'package:flutter/material.dart';

class GantiPasswordPage extends StatefulWidget {
  const GantiPasswordPage({super.key});

  @override
  State<GantiPasswordPage> createState() => _GantiPasswordPageState();
}

class _GantiPasswordPageState extends State<GantiPasswordPage> {
  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
              // Header dengan Tombol Back dan Judul
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Color(0xFF0F1B2B)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Ganti Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F1B2B),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40), // Penyeimbang posisi tengah
                ],
              ),
              const SizedBox(height: 20),

              // Kotak Form Ganti Password
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPasswordField(
                      label: 'Password Saat ini',
                      controller: _oldPasswordController,
                      obscureText: _obscureOld,
                      onToggleVisibility: () {
                        setState(() {
                          _obscureOld = !_obscureOld;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildPasswordField(
                      label: 'Password baru',
                      controller: _newPasswordController,
                      obscureText: _obscureNew,
                      onToggleVisibility: () {
                        setState(() {
                          _obscureNew = !_obscureNew;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    // Indikator Kekuatan Password (Bar Indikator)
                    Row(
                      children: [
                        Expanded(child: Container(height: 4, decoration: BoxDecoration(color: const Color(0xFF00A896), borderRadius: BorderRadius.circular(2)))),
                        const SizedBox(width: 4),
                        Expanded(child: Container(height: 4, decoration: BoxDecoration(color: const Color(0xFF00A896), borderRadius: BorderRadius.circular(2)))),
                        const SizedBox(width: 4),
                        Expanded(child: Container(height: 4, decoration: BoxDecoration(color: const Color(0xFF00A896), borderRadius: BorderRadius.circular(2)))),
                        const SizedBox(width: 4),
                        Expanded(child: Container(height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Kuat',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF00A896)),
                    ),
                    const SizedBox(height: 16),
                    _buildPasswordField(
                      label: 'Ulangi password baru',
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirm,
                      onToggleVisibility: () {
                        setState(() {
                          _obscureConfirm = !_obscureConfirm;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Kotak Syarat Password
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Syarat password',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    _buildRequirementItem('Minimal 8 Karakter', true),
                    const SizedBox(height: 8),
                    _buildRequirementItem('Mengandung huruf dan angka', true),
                    const SizedBox(height: 8),
                    _buildRequirementItem('Berbeda dari password lama', true),
                    const SizedBox(height: 8),
                    _buildRequirementItem('Tambah simbol agar lebih kuat', false),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Tombol Simpan Password
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A896),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password berhasil diubah!')),
                    );
                  },
                  child: const Text(
                    'Simpan password',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Helper untuk Input Password
  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F1B2B),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF7F9FC),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: Colors.grey,
                size: 20,
              ),
              onPressed: onToggleVisibility,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF00A896), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  // Widget Helper untuk Daftar Syarat Password
  Widget _buildRequirementItem(String text, bool isChecked) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isChecked ? const Color(0xFF00A896) : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isChecked ? Icons.check : Icons.circle,
            color: isChecked ? Colors.white : Colors.transparent,
            size: 12,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isChecked ? const Color(0xFF0F1B2B) : Colors.grey,
          ),
        ),
      ],
    );
  }
}