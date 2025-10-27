import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modern_grocery/bloc/Banner_/CreateBanner_bloc/create_banner_bloc.dart';
import 'package:modern_grocery/repositery/api/banner/CreateBanner_api.dart';
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
    if (!file.existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Image file not found')),
      );
      return;
    }

    print('Image path: ${widget.imagePath}');
    print('File exists: true');

    // Use context.read (or _createBannerBloc.add)
    // context.read is fine now since we will provide the bloc
    context.read<CreateBannerBloc>().add(
          FetchCreateBannerEvent(
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
          ),
        );
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
        style: const TextStyle(color: appColor.textColor),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: appColor.textColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: appColor.accentColor),
          ),
          filled: true,
          fillColor: appColor.backgroundColor,
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
      return Image.file(file, fit: BoxFit.cover);
    } else {
      return const Center(
        child: Text(
          'Image not found',
          style: TextStyle(color: appColor.textColor, fontSize: 16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    // --- FIX 1: Provide the BLoC to the widget tree ---
    //
    return BlocProvider(
      create: (context) => _createBannerBloc,
      child: Scaffold(
        backgroundColor: appColor.backgroundColor,
        appBar: AppBar(
          backgroundColor: appColor.backgroundColor,
          foregroundColor: appColor.textColor,
          title: Text('Banner Management'),
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
              Navigator.of(context).pop();
            } else if (state is CreateBannerError) {
              //
              // --- FIX 2: Show a SnackBar for the error ---
              //
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
                  // Image preview
                  Container(
                    height: 200.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: _buildImagePreview(),
                  ),
                  const SizedBox(height: 24),

                  // Upload progress
                  if (_uploadProgress > 0 && _uploadProgress < 1) ...[
                    LinearProgressIndicator(
                      value: _uploadProgress,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          appColor.accentColor),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Uploading: ${(_uploadProgress * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(color: appColor.textColor),
                    ),
                    const SizedBox(height: 16),
                  ],

                  Text(
                    'Banner Details',
                    style: TextStyle(
                      color: appColor.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(label: 'Title', controller: _titleController),
                  _buildTextField(
                      label: 'Category', controller: _categoryController),
                  _buildTextField(label: 'Type', controller: _typeController),
                  _buildTextField(
                      label: 'Category ID', controller: _categoryIdController),
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
                          backgroundColor: appColor.buttonColor,
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
      ),
    );
  }
}