import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

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
          'Terms & Conditions',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('1. Introduction'),
            _paragraph('SafeTrek is a safety companion app intended to help users plan journeys and access safety-related information. By using the app, you agree to these terms.'),
            _sectionTitle('2. No Emergency Service'),
            _paragraph('SafeTrek is not a replacement for emergency services. In case of danger or emergency, call your local emergency number immediately.'),
            _sectionTitle('3. User Responsibilities'),
            _bullet(['Provide accurate registration details','Keep your device and credentials secure','Use the app in compliance with local laws']),
            _sectionTitle('4. Data & Privacy'),
            _paragraph('Until backend integration, your data is stored locally on your device. When cloud features are enabled, data handling will follow our Privacy Policy.'),
            _sectionTitle('5. Location & Third-Party Data'),
            _paragraph('Any location, safety zones, or alerts may come from third parties and may not be accurate. Use discretion when acting on provided information.'),
            _sectionTitle('6. Content & Prohibited Use'),
            _bullet(['Do not upload illegal, harmful, or infringing content','Do not attempt to disrupt service or access data without permission']),
            _sectionTitle('7. Disclaimer of Warranties'),
            _paragraph('The app is provided “as is” without warranties of any kind. We do not guarantee accuracy, availability, or reliability of any information.'),
            _sectionTitle('8. Limitation of Liability'),
            _paragraph('We are not liable for any direct or indirect damages arising from your use of the app.'),
            _sectionTitle('9. Changes to Terms'),
            _paragraph('We may update these terms. Continued use after changes constitutes acceptance of the updated terms.'),
            _sectionTitle('10. Contact'),
            _paragraph('For questions about these terms, contact support@safetrek.example.'),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Last updated: Sep 2025',
                style: GoogleFonts.montserrat(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 6.0),
      child: Text(
        text,
        style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
      ),
    );
  }

  Widget _paragraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        text,
        style: GoogleFonts.montserrat(fontSize: 14, height: 1.6, color: Colors.black87),
      ),
    );
  }

  Widget _bullet(List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map((t) => Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• '),
                      Expanded(
                        child: Text(
                          t,
                          style: GoogleFonts.montserrat(fontSize: 14, height: 1.6, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}


