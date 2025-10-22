import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modern_grocery/bloc/Categories_/GetAllCategories/get_all_categories_bloc.dart';

import 'package:modern_grocery/bloc/Categories_/createCategory/create_category_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;

// Assuming Category is a class within GetAllCategoriesModel
class Category {
  final String name;
  final String imageUrl;

  Category({required this.name, required this.imageUrl});
}

class AdminCategory extends StatefulWidget {
  const AdminCategory({super.key});

  @override
  State<AdminCategory> createState() => _AdminCategoryState();
}

class _AdminCategoryState extends State<AdminCategory> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<GetAllCategoriesBloc>(context).add(fetchGetAllCategories());
  }

  File? _image;
  String? _imageFileType;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;
  final TextEditingController _categoryController = TextEditingController();

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  Future<bool> _requestImagePermission() async {
    final status = await Permission.photos.request();
    if (!status.isGranted) {
      final storageStatus = await Permission.storage.request();
      if (storageStatus.isPermanentlyDenied || status.isPermanentlyDenied) {
        await openAppSettings();
        return false;
      }
      return storageStatus.isGranted;
    }
    return true;
  }

  Future<void> _pickImage() async {
    final isGranted = await _requestImagePermission();
    if (!isGranted) {
      _showSnackBar('Permission to access photos is denied', Colors.red);
      return;
    }

    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        imageQuality: 85,
      );

      if (pickedFile == null) return;

      final imageFile = File(pickedFile.path);
      final bytes = await imageFile.readAsBytes();

      // Validate image format
      final isJpeg = bytes.length > 2 && bytes[0] == 0xFF && bytes[1] == 0xD8;
      final isPng = bytes.length > 4 &&
          bytes[0] == 0x89 &&
          bytes[1] == 0x50 &&
          bytes[2] == 0x4E &&
          bytes[3] == 0x47;

      if (!isJpeg && !isPng) {
        _showSnackBar('Only JPEG or PNG images are allowed', Colors.red);
        return;
      }

      setState(() {
        _image = imageFile;
        _imageFileType = isJpeg ? 'jpeg' : 'png';
      });
    } catch (e) {
      _showSnackBar('Error picking image: $e', Colors.red);
    }
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: backgroundColor),
    );
  }

  void _resetForm() {
    setState(() {
      _image = null;
      _categoryController.clear();
      _isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTopBar(),
              const SizedBox(height: 20),
              _buildSearchField(),
              const SizedBox(height: 20),
              _buildAddCategoryButton(),
              const SizedBox(height: 20),
              _buildCategoryGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Icon(Icons.print, color: Colors.white, semanticLabel: 'Print'),
        const SizedBox(width: 16),
        Stack(
          children: [
            const Icon(Icons.notifications_none,
                color: Colors.white, semanticLabel: 'Notifications'),
            Positioned(
              right: 0,
              child: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.orange,
                child: const Text(
                  '10',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                  semanticsLabel: '10 notifications',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        const Icon(Icons.person, color: Colors.white, semanticLabel: 'Profile'),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Search here',
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white54),
        ),
        prefixIcon: const Icon(Icons.search, color: Colors.white54),
      ),
    );
  }

  Widget _buildAddCategoryButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFF1C5),
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        onPressed: _showAddCategoryDialog,
        icon: const Icon(Icons.add_circle_outline,
            color: Colors.black, semanticLabel: 'Add'),
        label: const Text('Add Category'),
      ),
    );
  }

  void _showAddCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) =>
          BlocListener<CreateCategoryBloc, CreateCategoryState>(
        listener: (context, state) {
          if (state is CreateCategoryLoaded) {
            _resetForm();
            Navigator.of(context).pop();
            _showSnackBar('Category created successfully', Colors.green);
            // Refresh categories
            BlocProvider.of<GetAllCategoriesBloc>(context)
                .add(fetchGetAllCategories());
          } else if (state is CreateCategoryError) {
            setState(() => _isUploading = false);
            _showSnackBar(
                'Failed to create category: ${state.message}', Colors.red);
          }
        },
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Add New Category'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Category Name *',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter category name',
                    errorText:
                        _categoryController.text.trim().isEmpty && _isUploading
                            ? 'Category name is required'
                            : null,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Add Image *',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: _pickImage,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.image,
                            color: Colors.blue, semanticLabel: 'Image'),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _image != null
                                ? p.basename(_image!.path)
                                : 'Select an image',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color:
                                  _image != null ? Colors.black : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_isUploading && _image == null)
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'Image is required',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _resetForm();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
            ),
            ElevatedButton(
              onPressed: _handleCategorySubmission,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFF1C5),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
              ),
              child: _isUploading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save Category'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleCategorySubmission() {
    if (_categoryController.text.trim().isEmpty || _image == null) {
      setState(() => _isUploading = true); // Trigger validation
      _showSnackBar(
          'Please provide both a category name and an image', Colors.red);
      return;
    }

    if (!_image!.existsSync()) {
      _showSnackBar('Selected image is invalid', Colors.red);
      return;
    }

    setState(() => _isUploading = true);

    context.read<CreateCategoryBloc>().add(
          FetchCreateCategory(
            categoryName: _categoryController.text.trim(),
            imageFile: _image!,
          ),
        );
  }

  Widget _buildCategoryGrid() {
    return BlocBuilder<GetAllCategoriesBloc, GetAllCategoriesState>(
      builder: (context, state) {
        if (state is GetAllCategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetAllCategoriesError) {
          return const Center(
            child: Text(
              'Failed to load categories',
              style: TextStyle(color: Colors.white),
            ),
          );
        } else if (state is GetAllCategoriesLoaded) {
          final categories = state.categories;
          ;
          if (categories.isEmpty || categories.isEmpty) {
            return const Center(
              child: Text(
                'No categories available',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return Expanded(
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8E1D1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 20),
                            Image.network(
                              category.categories[0].image,
                              height: 80,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                Icons.broken_image,
                                size: 80,
                                semanticLabel: 'Image failed to load',
                              ),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const SizedBox(
                                  height: 80,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 15.h),
                            Text(
                              category.categories[0].name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              semanticsLabel: category.categories[0].name,
                            ),
                            SizedBox(height: 15),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'ACTIVE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                semanticsLabel: 'Category is active',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: SvgPicture.asset(
                            'assets/product_note.svg',
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn),
                            semanticsLabel: 'Edit category',
                          ),
                          onPressed: () {
                            // TODO: Implement edit functionality
                            _showSnackBar('Edit functionality not implemented',
                                Colors.blue);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox(); // Fallback for unhandled states
      },
    );
  }
}
