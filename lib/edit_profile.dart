import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String initialName;
  final String initialEmail;
  final String initialPhone;

  const EditProfilePage({
    super.key,
    required this.initialName,
    required this.initialEmail,
    required this.initialPhone,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;
  late TextEditingController _genderController;

  @override
  void initState() {
    super.initState();
    // Mengisi teks awal dengan data yang dikirim dari profil
    _nameController = TextEditingController(text: widget.initialName);
    _emailController = TextEditingController(text: widget.initialEmail);
    _phoneController = TextEditingController(text: widget.initialPhone);
    _dobController = TextEditingController(text: '12 Agustus 2002'); // Contoh data dummy
    _genderController = TextEditingController(text: 'Laki-laki'); // Contoh data dummy
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _genderController.dispose();
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
                      'Data Diri',
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

              // Avatar Lingkaran Inisial
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF00A896),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
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
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Kotak Kartu Form Putih
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
                    _buildTextField('Nama lengkap', _nameController),
                    const SizedBox(height: 16),
                    _buildTextField('Email', _emailController),
                    const SizedBox(height: 16),
                    _buildTextField('No HP', _phoneController),
                    const SizedBox(height: 16),
                    _buildTextField('Tanggal lahir', _dobController, suffixIcon: Icons.calendar_today_rounded),
                    const SizedBox(height: 16),
                    _buildTextField('Jenis kelamin', _genderController, suffixIcon: Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Tombol Scan Wajah
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
                    // Aksi untuk scan ulang wajah dari menu data diri
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Membuka kamera untuk scan wajah...')),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code_scanner_rounded, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Scan wajah',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Tombol Simpan Perubahan
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
                    // Aksi simpan perubahan
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Perubahan data diri berhasil disimpan!')),
                    );
                  },
                  child: const Text(
                    'Simpan Perubahan',
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

  // Widget Helper untuk Kotak Input (TextField)
  Widget _buildTextField(String label, TextEditingController controller, {IconData? suffixIcon}) {
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
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F1B2B),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF7F9FC),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.grey, size: 20) : null,
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
}