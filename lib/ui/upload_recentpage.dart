import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modern_grocery/bloc/CreateBanner_bloc/bloc/create_banner_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class _AppConstants {
  static const primaryColor = Color(0xFFF5E9B5);
  static const backgroundColor = Color(0xFF0A0909);
  static const textColor = Color(0xFFFCF8E8);
  static const accentColor = Colors.green;
  static const buttonColor = Color(0xFFFFF1C5);
  static const dialogRadius = 12.0;
  static const cardShadowColor = Colors.black54;
  static const cardHeight = 270.0;
  static const cardWidth = 190.0;
}

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

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _typeController.dispose();
    _categoryIdController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  void _saveImage(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final file = File(widget.imagePath);

      // Debug: Check if file exists and log the path
      print('Image path: ${widget.imagePath}');
      print('File exists: ${file.existsSync()}');

      if (!file.existsSync()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: Image file not found')),
        );
        return;
      }

      try {
        // Prepare the form data for multipart request
        final formData = {
          'title': _titleController.text,
          'category': _categoryController.text,
          'type': _typeController.text,
          'categoryId': _categoryIdController.text,
          'link': _linkController.text,
          'images': await http.MultipartFile.fromPath(
            'images',
            widget.imagePath,
            contentType: MediaType(
                'image', widget.imagePath.endsWith('.png') ? 'png' : 'jpeg'),
          ),
        };

        print('Form data prepared: $formData');

        // Dispatch the event to the BLoC
        context.read<CreateBannerBloc>().add(fetchCreateBannerEvent());
      } catch (e) {
        print('Error creating MultipartFile: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error preparing image: $e')),
        );
      }
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
        style: const TextStyle(color: _AppConstants.textColor),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: _AppConstants.textColor),
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
            borderSide: const BorderSide(color: _AppConstants.accentColor),
          ),
          filled: true,
          fillColor: _AppConstants.backgroundColor,
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
          style: TextStyle(color: _AppConstants.textColor, fontSize: 16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: _AppConstants.backgroundColor,
        foregroundColor: _AppConstants.textColor,
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
          } else if (state is CreateBannerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error')),
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
                // Image Preview Section
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

                // Form Fields Section
                const Text(
                  'Banner Details',
                  style: TextStyle(
                    color: _AppConstants.textColor,
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

                // Save Button
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
                      label: const Text('Save Banner'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _AppConstants.buttonColor,
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
