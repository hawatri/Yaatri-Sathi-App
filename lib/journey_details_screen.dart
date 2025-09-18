
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class JourneyDetailsScreen extends StatefulWidget {
  const JourneyDetailsScreen({super.key});

  @override
  State<JourneyDetailsScreen> createState() => _JourneyDetailsScreenState();
}

class _JourneyDetailsScreenState extends State<JourneyDetailsScreen> {
  final Map<String, TextEditingController> _controllers = {};
  String? _selectedTravelMedium;
  String? _selectedNationality;
  String? _identityProofFileName;
  String? _touristPhotoFileName;

  final List<String> _travelMediums = ['By Air', 'By Train', 'By Road', 'Other'];
  final List<String> _nationalities = [
    'Afghan', 'Albanian', 'Algerian', 'American', 'Andorran', 'Angolan', 'Antiguans', 'Argentinean', 'Armenian', 'Australian', 'Austrian', 'Azerbaijani',
    'Bahamian', 'Bahraini', 'Bangladeshi', 'Barbadian', 'Barbudans', 'Batswana', 'Belarusian', 'Belgian', 'Belizean', 'Beninese', 'Bhutanese', 'Bolivian', 'Bosnian', 'Brazilian', 'British', 'Bruneian', 'Bulgarian', 'Burkinabe', 'Burmese', 'Burundian',
    'Cambodian', 'Cameroonian', 'Canadian', 'Cape Verdean', 'Central African', 'Chadian', 'Chilean', 'Chinese', 'Colombian', 'Comoran', 'Congolese', 'Costa Rican', 'Croatian', 'Cuban', 'Cypriot', 'Czech',
    'Danish', 'Djibouti', 'Dominican', 'Dutch',
    'East Timorese', 'Ecuadorean', 'Egyptian', 'Emirian', 'Equatorial Guinean', 'Eritrean', 'Estonian', 'Ethiopian',
    'Fijian', 'Filipino', 'Finnish', 'French',
    'Gabonese', 'Gambian', 'Georgian', 'German', 'Ghanaian', 'Greek', 'Grenadian', 'Guatemalan', 'Guinea-Bissauan', 'Guinean', 'Guyanese',
    'Haitian', 'Herzegovinian', 'Honduran', 'Hungarian',
    'I-Kiribati', 'Icelandic', 'Indian', 'Indonesian', 'Iranian', 'Iraqi', 'Irish', 'Israeli', 'Italian', 'Ivorian',
    'Jamaican', 'Japanese', 'Jordanian',
    'Kazakhstani', 'Kenyan', 'Kittian and Nevisian', 'Kuwaiti', 'Kyrgyz',
    'Laotian', 'Latvian', 'Lebanese', 'Liberian', 'Libyan', 'Liechtensteiner', 'Lithuanian', 'Luxembourger',
    'Macedonian', 'Malagasy', 'Malawian', 'Malaysian', 'Maldivan', 'Malian', 'Maltese', 'Marshallese', 'Mauritanian', 'Mauritian', 'Mexican', 'Micronesian', 'Moldovan', 'Monacan', 'Mongolian', 'Moroccan', 'Mosotho', 'Motswana', 'Mozambican',
    'Namibian', 'Nauruan', 'Nepalese', 'New Zealander', 'Nicaraguan', 'Nigerian', 'Nigerien', 'North Korean', 'Northern Irish', 'Norwegian',
    'Omani',
    'Pakistani', 'Palauan', 'Panamanian', 'Papua New Guinean', 'Paraguayan', 'Peruvian', 'Polish', 'Portuguese',
    'Qatari',
    'Romanian', 'Russian', 'Rwandan',
    'Saint Lucian', 'Salvadoran', 'Samoan', 'San Marinese', 'Sao Tomean', 'Saudi', 'Scottish', 'Senegalese', 'Serbian', 'Seychellois', 'Sierra Leonean', 'Singaporean', 'Slovakian', 'Slovenian', 'Solomon Islander', 'Somali', 'South African', 'South Korean', 'Spanish', 'Sri Lankan', 'Sudanese', 'Surinamer', 'Swazi', 'Swedish', 'Swiss', 'Syrian',
    'Taiwanese', 'Tajik', 'Tanzanian', 'Thai', 'Togolese', 'Tongan', 'Trinidadian or Tobagonian', 'Tunisian', 'Turkish', 'Tuvaluan',
    'Ugandan', 'Ukrainian', 'Uruguayan', 'Uzbekistani',
    'Venezuelan', 'Vietnamese',
    'Welsh',
    'Yemenite',
    'Zambian', 'Zimbabwean'
  ];

  @override
  void initState() {
    super.initState();
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

  Future<void> _pickFile(String fieldName) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      int sizeInBytes = await file.length();
      double sizeInMb = sizeInBytes / (1024 * 1024);

      if (sizeInMb > 5) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File size cannot exceed 5MB')),
        );
      } else {
        setState(() {
          if (fieldName == 'Identity Proof') {
            _identityProofFileName = result.files.single.name;
          }
        });
      }
    }
  }

  Future<void> _pickImage(String fieldName) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File file = File(image.path);
      int sizeInBytes = await file.length();
      double sizeInMb = sizeInBytes / (1024 * 1024);

      if (sizeInMb > 5) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image size cannot exceed 5MB')),
        );
      } else {
        setState(() {
          if (fieldName == 'Tourist Photo') {
            _touristPhotoFileName = image.name;
          }
        });
      }
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
            _buildDropdownField('Select Travel Medium', _selectedTravelMedium, _travelMediums, (newValue) {
              setState(() {
                _selectedTravelMedium = newValue;
              });
            }),
            const SizedBox(height: 20),
            _buildSectionTitle('Identity Proof Attachment'),
            _buildUploadField('Upload Document', 'Identity Proof', _identityProofFileName, () => _pickFile('Identity Proof')),
            const SizedBox(height: 20),
            _buildSectionTitle('Passport/Aadhar Number'),
            _buildTextField('Enter Number'),
            const SizedBox(height: 20),
            _buildSectionTitle('Nationality'),
            _buildDropdownField('Select Nationality', _selectedNationality, _nationalities, (newValue) {
              setState(() {
                _selectedNationality = newValue;
              });
            }),
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
            _buildUploadField('Upload Tourist Photo', 'Tourist Photo', _touristPhotoFileName, () => _pickImage('Tourist Photo')),
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
                Navigator.pop(context);
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

  Widget _buildDropdownField(String hint, String? value, List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(
            hint,
            style: GoogleFonts.montserrat(color: Colors.grey.shade600, fontSize: 15),
          ),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildUploadField(String hint, String fieldName, String? fileName, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
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
            Expanded(
              child: Text(
                fileName ?? hint,
                style: GoogleFonts.montserrat(color: fileName != null ? Colors.black : Colors.grey.shade600, fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
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
