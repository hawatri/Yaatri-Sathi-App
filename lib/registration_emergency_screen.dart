import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './home_screen.dart';

class RegistrationEmergencyScreen extends StatefulWidget {
  const RegistrationEmergencyScreen({super.key});

  @override
  State<RegistrationEmergencyScreen> createState() => _RegistrationEmergencyScreenState();
}

class _RegistrationEmergencyScreenState extends State<RegistrationEmergencyScreen> {
  final TextEditingController _name1 = TextEditingController();
  final TextEditingController _phone1 = TextEditingController();
  final TextEditingController _relation1 = TextEditingController();
  final TextEditingController _name2 = TextEditingController();
  final TextEditingController _phone2 = TextEditingController();
  final TextEditingController _relation2 = TextEditingController();

  @override
  void dispose() {
    _name1.dispose();
    _phone1.dispose();
    _relation1.dispose();
    _name2.dispose();
    _phone2.dispose();
    _relation2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Emergency Contacts',
          style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            _buildSection('Primary Contact', _name1, _phone1, _relation1),
            const SizedBox(height: 20),
            _buildSection('Secondary Contact (optional)', _name2, _phone2, _relation2, optional: true),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D8ECE),
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'Finish',
                style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, TextEditingController name, TextEditingController phone, TextEditingController relation, {bool optional = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
        const SizedBox(height: 10),
        _field('Full Name', controller: name),
        const SizedBox(height: 12),
        _field('Phone Number', controller: phone, keyboardType: TextInputType.phone),
        const SizedBox(height: 12),
        _field('Relation (e.g., Father, Friend)', controller: relation),
      ],
    );
  }

  Widget _field(String hint, {TextEditingController? controller, TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.montserrat(color: Colors.grey.shade600, fontSize: 15),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    );
  }
}


