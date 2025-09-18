
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportIncidentScreen extends StatefulWidget {
  const ReportIncidentScreen({super.key});

  @override
  _ReportIncidentScreenState createState() => _ReportIncidentScreenState();
}

class _ReportIncidentScreenState extends State<ReportIncidentScreen> {
  String? _selectedIncidentType;
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  final List<String> _incidentTypes = [
    'Harassment',
    'Theft',
    'Vandalism',
    'Assault',
    'Other',
  ];

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
          'Report Incident',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Incident Type'),
            _buildIncidentTypeDropdown(),
            const SizedBox(height: 20),
            _buildSectionTitle('Description of Incident'),
            _buildDescriptionInput(),
            const SizedBox(height: 20),
            _buildSectionTitle('Location'),
            _buildLocationInput(),
            const SizedBox(height: 20),
            _buildSectionTitle('Attach Evidence'),
            _buildEvidenceUploader(),
            const SizedBox(height: 20),
            _buildWarning(),
            const SizedBox(height: 20),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
      ),
    );
  }

  Widget _buildIncidentTypeDropdown() {
    return DropdownButtonFormField<String>(
      decoration: _inputDecoration('Select Incident Type'),
      value: _selectedIncidentType,
      items: _incidentTypes.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedIncidentType = newValue;
        });
      },
    );
  }

  Widget _buildDescriptionInput() {
    return TextFormField(
      controller: _descriptionController,
      maxLines: 4,
      decoration: _inputDecoration('Provide a detailed description of what happened...'),
    );
  }

  Widget _buildLocationInput() {
    return TextFormField(
      controller: _locationController,
      decoration: _inputDecoration('Enter Location or use current').copyWith(
        suffixIcon: IconButton(
          icon: const Icon(Icons.my_location),
          onPressed: () {
            // TODO: Implement get current location
          },
        ),
      ),
    );
  }

  Widget _buildEvidenceUploader() {
    return GestureDetector(
      onTap: () {
        // TODO: Implement file upload
      },
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_upload_outlined, size: 50, color: Colors.grey),
            const SizedBox(height: 10),
            Text(
              'Click to upload or drag and drop',
              style: GoogleFonts.montserrat(color: Colors.grey[600]),
            ),
            const SizedBox(height: 5),
            Text(
              'PNG, JPG, MP4 (MAX. 50MB)',
              style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarning() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        'In case of any false report, strict actions will be taken.',
        style: GoogleFonts.montserrat(color: Colors.red[700]),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implement submit report
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[700],
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          'Submit Report',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.montserrat(color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF0D8ECE)),
      ),
    );
  }
}
