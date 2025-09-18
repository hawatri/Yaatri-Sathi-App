
import '''package:flutter/material.dart''';
import '''package:google_fonts/google_fonts.dart''';
import '''package:intl/intl.dart''';

class JourneyDetailsScreen extends StatefulWidget {
  const JourneyDetailsScreen({super.key});

  @override
  State<JourneyDetailsScreen> createState() => _JourneyDetailsScreenState();
}

class _JourneyDetailsScreenState extends State<JourneyDetailsScreen> {
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each date field
    [
      'Departure Date',
      'Arrival Date',
      'Date of Birth',
      'Planned Date 1',
      'Planned Date 2'
    ].forEach((field) {
      _controllers[field] = TextEditingController();
    });
  }

  Future<void> _selectDate(BuildContext context, String field) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _controllers[field]!.text = DateFormat.yMMMd().format(picked);
      });
    }
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
          'Journey Details',
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
            _buildSectionTitle('Departure Date'),
            _buildDateField('Departure Date'),
            const SizedBox(height: 20),
            _buildSectionTitle('Arrival Date'),
            _buildDateField('Arrival Date'),
            const SizedBox(height: 20),
            _buildSectionTitle('Hotel Name'),
            _buildTextField('Enter Hotel Name'),
            const SizedBox(height: 20),
            _buildSectionTitle('Hotel Contact Number'),
            _buildTextField('Enter Contact Number'),
            const SizedBox(height: 20),
            _buildSectionTitle('Travel Medium'),
            _buildDropdownField('Select Travel Medium'),
            const SizedBox(height: 20),
            _buildSectionTitle('Identity Proof Attachment'),
            _buildUploadField('Upload Document'),
            const SizedBox(height: 20),
            _buildSectionTitle('Passport/Aadhar Number'),
            _buildTextField('Enter Number'),
            const SizedBox(height: 20),
            _buildSectionTitle('Nationality'),
            _buildDropdownField('Select Nationality'),
            const SizedBox(height: 20),
            _buildSectionTitle('KYC Information'),
            _buildTextField('Enter KYC Details'),
            const SizedBox(height: 20),
            _buildSectionTitle('Date of Birth'),
            _buildDateField('Date of Birth'),
            const SizedBox(height: 20),
            _buildSectionTitle('Visa Information (if applicable)'),
            _buildTextField('Enter Visa Details'),
            const SizedBox(height: 20),
            _buildUploadField('Upload Tourist Photo'),
            const SizedBox(height: 30),
            _buildSectionHeader('Family Members'),
            _buildSectionTitle('Family Members\' Names'),
            _buildTextField('Enter Names, separated by commas', maxLines: 3),
            const SizedBox(height: 30),
            _buildSectionHeader('Next of Kin'),
            _buildSectionTitle('Next of Kin\'s Name'),
            _buildTextField('Enter Name'),
            const SizedBox(height: 20),
            _buildSectionTitle('Relation to Next of Kin'),
            _buildTextField('Enter Relation'),
            const SizedBox(height: 30),
            _buildSectionHeader('Travel Itinerary'),
            _buildSectionTitle('Planned Date 1'),
            _buildDateField('Planned Date 1'),
            const SizedBox(height: 20),
            _buildSectionTitle('Location 1'),
            _buildTextField('Enter Location'),
            const SizedBox(height: 20),
            _buildSectionTitle('Planned Date 2'),
            _buildDateField('Planned Date 2'),
            const SizedBox(height: 20),
            _buildSectionTitle('Location 2'),
            _buildTextField('Enter Location'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement submit logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D8ECE),
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Submit',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
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

  Widget _buildDateField(String field) {
    return InkWell(
      onTap: () => _selectDate(context, field),
      child: AbsorbPointer(
        child: TextFormField(
          controller: _controllers[field],
          decoration: InputDecoration(
            hintText: 'Select Date',
            hintStyle: GoogleFonts.montserrat(color: Colors.grey.shade600, fontSize: 15),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            suffixIcon: const Icon(Icons.calendar_today_outlined, color: Colors.grey, size: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(
            hint,
            style: GoogleFonts.montserrat(color: Colors.grey.shade600, fontSize: 15),
          ),
          items: [],
          onChanged: (value) {},
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
        ),
      ),
    );
  }

    Widget _buildUploadField(String hint) {
    return InkWell(
      onTap: () {
        // TODO: Show file picker
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.upload_file, color: Colors.grey, size: 20),
            const SizedBox(width: 10),
            Text(
              hint,
              style: GoogleFonts.montserrat(color: Colors.grey.shade600, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }
}
