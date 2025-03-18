import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'dart:typed_data'; // For Uint8List
import '../../../core/constants/app_constants.dart';
import '../../../data/services/api_service.dart';
import '../../../data/models/course.dart';
import '../study_detail/study_detail_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? _filePath;
  bool _isLoading = false;
  PlatformFile? _pickedFile;
  final TextEditingController _titleController = TextEditingController();

  Future<void> _selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _pickedFile = result.files.single;
        if (kIsWeb) {
          _filePath = _pickedFile!.name;
        } else {
          _filePath = _pickedFile!.path;
        }
      });
    } else {
      setState(() {
        _pickedFile = null;
        _filePath = null;
      });
    }
  }

  Future<void> _uploadFile() async {
    if (_filePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a file before uploading.')),
      );
      return;
    }

    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title before uploading.')),
      );
      return;
    }

    final apiService = ApiService();
    setState(() {
      _isLoading = true;
    });

    if (_pickedFile != null) {
      final String title = _titleController.text;

      try {
        Course uploadedCourse;

        if (kIsWeb) {
          final fileBytes = _pickedFile!.bytes;
          uploadedCourse = await apiService.uploadFile(title, fileBytes!);
        } else {
          File file = File(_filePath!);
          uploadedCourse = await apiService.uploadFile(title, file);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File uploaded successfully')),
        );

        _navigateToCourseSection(id: uploadedCourse.id);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error during upload: $error')),
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _removeFile() {
    setState(() {
      _filePath = null;
      _pickedFile = null;
    });
  }

  void _navigateToCourseSection({required int id}) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => StudyDetailScreen(id: id)),
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey.shade800),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Upload File',
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter course title',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _selectFile,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.attach_file, color: Colors.grey.shade600),
                    const SizedBox(width: 8),
                    Text(
                      'Choose a File',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_filePath != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green.shade400),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _filePath!,
                        style: TextStyle(color: Colors.grey.shade800),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.grey.shade600),
                      onPressed: _removeFile,
                    ),
                  ],
                ),
              ),
            if (_filePath != null) const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _filePath == null || _isLoading ? null : _uploadFile,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: _isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Upload',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
