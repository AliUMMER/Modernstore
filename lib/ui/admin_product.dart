import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modern_grocery/bloc/createProduct/bloc/create_product_bloc.dart';
import 'package:modern_grocery/bloc/get_all_product/get_all_product_bloc.dart';
import 'package:modern_grocery/repositery/model/getAllProduct.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:badges/badges.dart' as badges;

import 'package:modern_grocery/bloc/createProduct/bloc/create_product_bloc.dart';

// Constants for reusability
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

// Sample category model (adjust as per your actual model)
class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});
}

class AdminProduct extends StatefulWidget {
  const AdminProduct({super.key});

  @override
  State<AdminProduct> createState() => _AdminProductState();
}

class _AdminProductState extends State<AdminProduct> {
  File? _image;
  String? _imageFileType;
  bool _isUploading = false;
  String? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    // Fetch categories and banner data when the widget initializes
    BlocProvider.of<GetAllProductBloc>(context).add(fetchGetAllProduct());
  }

  late GetAllProduct data;

  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Sample category list (replace with actual data from your backend)
  final List<Category> categoryList = [
    Category(id: "663fcaaa9047be29e47160f2", name: "Fruits"),
    Category(id: "67ec290adaa2fb3cd2af3a2a", name: "Vegetables"),
    Category(id: "663fcaaa9047be29e47160f4", name: "Drinks"),
  ];

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    unitController.dispose();
    discountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<bool> _requestImagePermission() async {
    var status = await Permission.photos.request();
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
    return status.isGranted;
  }

  Future<void> _pickImage() async {
    final isGranted = await _requestImagePermission();
    if (!isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission to access photos is denied')),
      );
      return;
    }

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        final bytes = await imageFile.readAsBytes();

        final isJpeg = bytes.length > 2 && bytes[0] == 0xFF && bytes[1] == 0xD8;
        final isPng = bytes.length > 4 &&
            bytes[0] == 0x89 &&
            bytes[1] == 0x50 &&
            bytes[2] == 0x4E &&
            bytes[3] == 0x47;

        if (!isJpeg && !isPng) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Only JPEG or PNG images are allowed'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        setState(() {
          _image = imageFile;
          _imageFileType = isJpeg ? 'jpeg' : 'png';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  void _showAddProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_AppConstants.dialogRadius),
        ),
        backgroundColor: _AppConstants.textColor,
        title: const Text(
          'Add Product',
          style: TextStyle(color: _AppConstants.backgroundColor),
        ),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  style: const TextStyle(color: _AppConstants.backgroundColor),
                  decoration: InputDecoration(
                    hintText: 'Product Name',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) => value?.trim().isEmpty ?? true
                      ? 'Enter product name'
                      : null,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: selectedCategoryId,
                  items: categoryList.map((category) {
                    return DropdownMenuItem<String>(
                      value: category.id,
                      child: Text(category.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategoryId = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Select Category',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) =>
                      value == null ? 'Select a category' : null,
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: priceController,
                  style: const TextStyle(color: _AppConstants.backgroundColor),
                  decoration: InputDecoration(
                    hintText: 'Price (e.g., 99.99)',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) return 'Enter price';
                    final price = double.tryParse(value!.trim());
                    if (price == null || price <= 0) {
                      return 'Enter a valid positive number';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: unitController,
                  style: const TextStyle(color: _AppConstants.backgroundColor),
                  decoration: InputDecoration(
                    hintText: 'Unit (e.g., kg, liter)',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) =>
                      value?.trim().isEmpty ?? true ? 'Enter unit' : null,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: discountController,
                  style: const TextStyle(color: _AppConstants.backgroundColor),
                  decoration: InputDecoration(
                    hintText: 'Discount Percentage (0-100)',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) return 'Enter discount';
                    final discount = double.tryParse(value!.trim());
                    if (discount == null || discount < 0 || discount > 100) {
                      return 'Enter a valid percentage (0-100)';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: descriptionController,
                  style: const TextStyle(color: _AppConstants.backgroundColor),
                  decoration: InputDecoration(
                    hintText: 'Product Description',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLines: 3,
                  validator: (value) => value?.trim().isEmpty ?? true
                      ? 'Enter description'
                      : null,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: 12.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _AppConstants.buttonColor,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(_AppConstants.dialogRadius),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    minimumSize: Size(double.infinity, 48.h),
                  ),
                  onPressed: _pickImage,
                  child: Text(
                    _image == null ? 'Pick Image' : 'Change Image',
                    semanticsLabel:
                        _image == null ? 'Pick image button' : 'Change image',
                  ),
                ),
                if (_image != null) ...[
                  SizedBox(height: 12.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.file(
                      _image!,
                      height: 100.h,
                      width: 100.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      'Selected: ${_image!.path.split('/').last}',
                      style: const TextStyle(
                        color: _AppConstants.backgroundColor,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.blue),
              semanticsLabel: 'Cancel dialog',
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _AppConstants.buttonColor,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_AppConstants.dialogRadius),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            onPressed: _isUploading
                ? null
                : () async {
                    if (_formKey.currentState!.validate() &&
                        _image != null &&
                        selectedCategoryId != null) {
                      // Check image file
                      if (!await _image!.exists()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Selected image file is no longer available'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      // Validate and parse input
                      final name = nameController.text.trim();
                      final description = descriptionController.text.trim();
                      final priceText = priceController.text.trim();
                      final unit = unitController.text.trim();
                      final discountText = discountController.text.trim();

                      final price = double.tryParse(priceText);
                      final discount = double.tryParse(discountText);

                      if (price == null || discount == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Please enter valid numbers for price and discount.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      setState(() => _isUploading = true);
                      context.read<CreateProductBloc>().add(
                            fetchCreateProduct(
                              productName: nameController.text.trim(),
                              productDescription:
                                  descriptionController.text.trim(),
                              categoryId: selectedCategoryId!,
                              price:
                                  double.tryParse(priceController.text.trim())
                                          ?.toString() ??
                                      '0',
                              unit: unitController.text.trim(),
                              imageFile: _image!,
                              discountPercentage: double.tryParse(
                                          discountController.text.trim())
                                      ?.toString() ??
                                  '0',
                            ),
                          );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            _image == null
                                ? 'Please select an image'
                                : 'Please select a category',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
            child: _isUploading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
                    'Save Product',
                    semanticsLabel: 'Save product button',
                  ),
          ),
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> fruits = [
    {
      'name': 'Banana',
      'image': 'assets/Banana.png',
      'price': 80,
      'mrp': 100,
      'rating': 4
    },
    {
      'name': 'Carrot',
      'image': 'assets/Carrot.png',
      'price': 80,
      'mrp': 100,
      'rating': 3
    },
  ];

  final List<Map<String, dynamic>> vegetables = [
    {
      'name': 'Chilli Green',
      'image': 'assets/Chilli Green.png',
      'price': 80,
      'mrp': 100,
      'rating': 3
    },
  ];

  final List<Map<String, dynamic>> drinks = [
    {
      'name': 'Mango Fruit Drink',
      'image': 'assets/Mango Fruit Drink.png',
      'price': 80,
      'mrp': 100,
      'rating': 5
    },
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(375, 812), minTextAdapt: true);

    return Scaffold(
      backgroundColor: _AppConstants.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                _buildAppBar(),
                SizedBox(height: 24.h),
                _buildSearchBar(),
                SizedBox(height: 24.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: BlocListener<CreateProductBloc, CreateProductState>(
                    listener: (context, state) {
                      if (state is CreateProductLoaded) {
                        setState(() {
                          _image = null;
                          nameController.clear();
                          priceController.clear();
                          unitController.clear();
                          discountController.clear();
                          descriptionController.clear();
                          selectedCategoryId = null;
                          _isUploading = false;
                        });
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Product added successfully'),
                            backgroundColor: _AppConstants.accentColor,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (state is CreateProductError) {
                        setState(() => _isUploading = false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Failed to create product: ${state.message}'),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    child: GestureDetector(
                      onTap: () => _showAddProductDialog(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: _AppConstants.primaryColor,
                          borderRadius: BorderRadius.circular(39.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4.r,
                              offset: Offset(0, 2.h),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add_circle_outline_outlined,
                                color: Colors.black, size: 20.w),
                            SizedBox(width: 8.w),
                            Text(
                              'Add Products',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                              semanticsLabel: 'Add products button',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                _buildSectionTitle('Fruits'),
                _buildProductList(fruits, (item) => FruitCard(item: item)),
                SizedBox(height: 32.h),
                _buildSectionTitle('Vegetables'),
                _buildProductList(
                    vegetables, (item) => VegetableCard(item: item)),
                SizedBox(height: 32.h),
                _buildSectionTitle('Drinks'),
                _buildProductList(drinks, (item) => DrinksCard(item: item)),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: _AppConstants.textColor,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        badges.Badge(
          badgeContent:
              Text('3', style: TextStyle(color: Colors.white, fontSize: 10.sp)),
          badgeStyle: badges.BadgeStyle(
            badgeColor: _AppConstants.accentColor,
            padding: EdgeInsets.all(6.w),
          ),
          child:
              SvgPicture.asset('assets/Group.svg', width: 24.w, height: 24.h),
        ),
        SizedBox(width: 24.w),
        SvgPicture.asset('assets/Group 6918.svg', width: 24.w, height: 24.h),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: _AppConstants.textColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: _AppConstants.textColor.withOpacity(0.57)),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                hintStyle: TextStyle(
                  color: _AppConstants.textColor.withOpacity(0.57),
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: _AppConstants.textColor,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(List<Map<String, dynamic>> items,
      Widget Function(Map<String, dynamic>) builder) {
    return SizedBox(
      height: _AppConstants.cardHeight.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 0 : 12.w, right: 12.w),
            child: builder(items[index]),
          );
        },
      ),
    );
  }
}

class FruitCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const FruitCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) => _ProductCard(item: item, type: 'Fruit');
}

class VegetableCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const VegetableCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) =>
      _ProductCard(item: item, type: 'Vegetable');
}

class DrinksCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const DrinksCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) => _ProductCard(item: item, type: 'Drink');
}

class _ProductCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final String type;

  const _ProductCard({required this.item, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _AppConstants.cardHeight.h,
      width: _AppConstants.cardWidth.w,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: _AppConstants.cardShadowColor,
            blurRadius: 5.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.h),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 150.h,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: _AppConstants.textColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      item['image'] ?? 'assets/default_image.png',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                Positioned(
                  top: 120.h,
                  left: 16.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: _AppConstants.accentColor,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      'ACTIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    item['name'] ?? 'Unknown $type',
                    style: TextStyle(
                      color: _AppConstants.textColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(width: 8.w),
                SvgPicture.asset(
                  'assets/product_note.svg',
                  width: 20.w,
                  semanticsLabel: 'Product note icon',
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < (item['rating'] ?? 0) ? Icons.star : Icons.star_border,
                color: const Color(0xFFFFD500),
                size: 16.w,
              );
            }),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: [
                Text(
                  '₹${item['price'] ?? 'N/A'}',
                  style: TextStyle(
                    color: _AppConstants.textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'MRP ₹${item['mrp'] ?? 'N/A'}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.sp,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              item['mrp'] != null && item['price'] != null
                  ? '${((1 - (item['price'] / item['mrp'])) * 100).toStringAsFixed(0)}% OFF'
                  : 'Discount Unavailable',
              style: TextStyle(
                color: _AppConstants.accentColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
