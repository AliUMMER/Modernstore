import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:modern_grocery/bloc/CreateBanner_bloc/create_banner_bloc.dart';
import 'package:modern_grocery/repositery/api/createbanner_api.dart';
import 'package:modern_grocery/widgets/app_color.dart';

class RecentPage extends StatefulWidget {
  final String imagePath;
  const RecentPage({super.key, required this.imagePath});

  @override
  State<RecentPage> createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _typeController = TextEditingController();
  final _categoryIdController = TextEditingController();
  final _linkController = TextEditingController();
  double _uploadProgress = 0.0;
  late CreateBannerBloc _createBannerBloc;
  @override
  void initState() {
    super.initState();
    _createBannerBloc = CreateBannerBloc(api: CreatebannerApi());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _typeController.dispose();
    _categoryIdController.dispose();
    _linkController.dispose();
    _createBannerBloc.close();
    super.dispose();
  }

  Future<void> _saveImage(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final file = File(widget.imagePath);

    print('Image path: ${widget.imagePath}');
    print('File exists: ${file.existsSync()}');

    if (!file.existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Image file not found')),
      );
      return;
    }

    try {
      final fileName = widget.imagePath.split('/').last;
      final extension = fileName.split('.').last.toLowerCase();
      final contentType =
          MediaType('image', extension == 'png' ? 'png' : 'jpeg');

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://modern-store-backend.onrender.com/api/banner/create'),
      )
        ..fields['title'] = _titleController.text
        ..fields['category'] = _categoryController.text
        ..fields['type'] = _typeController.text
        ..fields['categoryId'] = _categoryIdController.text
        ..fields['link'] = _linkController.text
        ..files.add(await http.MultipartFile.fromPath(
          'images',
          widget.imagePath,
          filename: fileName,
          contentType: contentType,
        ));

      print(
          'Multipart request prepared: fields=${request.fields}, files=${request.files.map((f) => f.filename).toList()}');

      context.read<CreateBannerBloc>().add(FetchCreateBannerEvent(
            // formData: request,

            title: _titleController.text,
            category: _categoryController.text,
            type: _typeController.text,
            categoryId: _categoryIdController.text,
            link: _linkController.text,
            imagePath: widget.imagePath,
            onSendProgress: (sent, total) {
              setState(() {
                _uploadProgress = sent / total;
              });
            },
          ));
    } catch (e) {
      print('Error preparing request: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error preparing request: $e')),
      );
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool isRequired = true,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: AppConstants.textColor),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppConstants.textColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppConstants.accentColor),
          ),
          filled: true,
          fillColor: AppConstants.backgroundColor,
        ),
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter $label';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _buildImagePreview() {
    final file = File(widget.imagePath);
    if (file.existsSync()) {
      return Image.file(
        file,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(Icons.error, color: Colors.red, size: 50),
        ),
      );
    } else {
      return const Center(
        child: Text(
          'Image not found',
          style: TextStyle(color: AppConstants.textColor, fontSize: 16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.backgroundColor,
        foregroundColor: AppConstants.textColor,
        title: const Text('Banner Management'),
        elevation: 0,
      ),
      body: BlocListener<CreateBannerBloc, CreateBannerState>(
        listener: (context, state) {
          if (state is CreateBannerLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Banner saved successfully!')),
            );
            _titleController.clear();
            _categoryController.clear();
            _typeController.clear();
            _categoryIdController.clear();
            _linkController.clear();
            setState(() => _uploadProgress = 0.0);
          } else if (state is CreateBannerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: _buildImagePreview(),
                ),
                const SizedBox(height: 24),
                if (_uploadProgress > 0 && _uploadProgress < 1)
                  Column(
                    children: [
                      LinearProgressIndicator(
                        value: _uploadProgress,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            AppConstants.accentColor),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Uploading: ${(_uploadProgress * 100).toStringAsFixed(0)}%',
                        style: const TextStyle(color: AppConstants.textColor),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                const Text(
                  'Banner Details',
                  style: TextStyle(
                    color: AppConstants.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Title',
                  controller: _titleController,
                ),
                _buildTextField(
                  label: 'Category',
                  controller: _categoryController,
                ),
                _buildTextField(
                  label: 'Type',
                  controller: _typeController,
                ),
                _buildTextField(
                  label: 'Category ID',
                  controller: _categoryIdController,
                ),
                _buildTextField(
                  label: 'Link',
                  controller: _linkController,
                  isRequired: false,
                ),
                const SizedBox(height: 24),
                BlocBuilder<CreateBannerBloc, CreateBannerState>(
                  builder: (context, state) {
                    return ElevatedButton.icon(
                      onPressed: state is CreateBannerLoading
                          ? null
                          : () => _saveImage(context),
                      icon: state is CreateBannerLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(Icons.save),
                      label: Text(state is CreateBannerLoading
                          ? 'Uploading...'
                          : 'Save Banner'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.buttonColor,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
