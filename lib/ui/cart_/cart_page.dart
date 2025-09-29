import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_grocery/bloc/GetAllUserCart/get_all_user_cart_bloc.dart';
import 'package:modern_grocery/services/language_service.dart';
import 'package:modern_grocery/ui/bottom_navigationbar.dart';
import 'package:modern_grocery/ui/delivery/delivery_address.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String selectedPaymentMethod = 'Cash on Delivery';

  @override
  void initState() {
    super.initState();
    // Trigger the API call when the page loads
    // context.read<GetAllUserCartBloc>().add(fetchGetAllUserCartEvent());
  }

  final List<Map<String, dynamic>> favourites = [
    {
      'name': 'Banana',
      'image': 'assets/Banana.png',
      'price': 80,
      'mrp': 100,
    },
    {
      'name': 'Carrot',
      'image': 'assets/Carrot.png',
      'price': 80,
      'mrp': 100,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0XFF0A0909),
            leading: BackButton(
              color: const Color(0xffFCF8E8),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigationBarWidget(),
                  ),
                );
              },
            ),
          ),
          backgroundColor: const Color(0XFF0A0909),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                children: [
                  SizedBox(height: 18.h),
                  Center(
                    child: Text(
                      languageService.getString('cart'),
                      style: GoogleFonts.poppins(
                        color: Color(0xFFFCF8E8),
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.24,
                      ),
                    ),
                  ),
                  SizedBox(height: 63.h),

                  // BlocBuilder<GetAllUserCartBloc, GetAllUserCartState>(
                  //   builder: (context, state) {
                  //     if (state is GetAllUserCartLoading) {
                  //       return const Center(child: CircularProgressIndicator());
                  //     } else if (state is GetAllUserCartLoaded) {
                  //       final cartModel =
                  //           context.read<GetAllUserCartBloc>().getAllUserCartModel;
                  //
                  //       if (cartModel == null ||
                  //           cartModel.data == null ||
                  //           cartModel.data?.allCartItems == null ||
                  //           cartModel.data!.allCartItems!.isEmpty) {
                  //         return Center(
                  //           child: Text(
                  //             languageService.getString('cart_empty'),
                  //             style: TextStyle(color: Colors.white70, fontSize: 18),
                  //           ),
                  //         );
                  //       }
                  //
                  //       final cartItems = cartModel.data?.allCartItems!;
                  //       return SizedBox(
                  //         height: 120 * cartItems!.length.toDouble(),
                  //         child: Column(
                  //           children: cartItems.map((item) {
                  //             return FavouriteItemCard(
                  //               item: {
                  //                 'name': item.productId ?? 'Unknown Item',
                  //                 'image': item.quantity ?? 'assets/placeholder.png',
                  //                 'price': item.unit ?? 0.0,
                  //                 'mrp': item.quantity ?? item.totalAmount ?? 0.0,
                  //               },
                  //               languageService: languageService,
                  //             );
                  //           }).toList(),
                  //         ),
                  //       );
                  //     } else if (state is GetAllUserCartError) {
                  //       return Center(
                  //         child: Text(
                  //           languageService.getString('error_loading_cart'),
                  //           style: TextStyle(color: Colors.red, fontSize: 18),
                  //         ),
                  //       );
                  //     }
                  //     return const SizedBox();
                  //   },
                  // ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: favourites.length,
                    itemBuilder: (context, index) {
                      final item = favourites[index];
                      return FavouriteItemCard(
                        item: item,
                        languageService: languageService,
                      );
                    },
                  ),
                  _buildCheckoutSection(languageService),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCheckoutSection(LanguageService languageService) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: languageService.getString('promo_code'),
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF5E9B5),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                ),
                child: Text(
                  languageService.getString('apply'),
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h),
          BlocBuilder<GetAllUserCartBloc, GetAllUserCartState>(
            builder: (context, state) {
              double totalPrice = 0;
              if (state is GetAllUserCartLoaded) {
                final cartModel =
                    context.read<GetAllUserCartBloc>().getAllUserCartModel;
                if (cartModel != null &&
                    cartModel.data != null &&
                    cartModel.data?.allCartItems != null) {}
              }
              return Column(
                children: [
                  _buildPriceRow(languageService.getString('price'),
                      '₹${totalPrice.toStringAsFixed(2)}', languageService),
                  _buildPriceRow(
                      languageService.getString('discount'), '₹5.00', languageService),
                  _buildPriceRow(languageService.getString('delivery_charge'),
                      '₹20.00', languageService),
                  Divider(color: Colors.white70, thickness: 1.h),
                  _buildPriceRow(
                      languageService.getString('grand_total'),
                      '₹${(totalPrice + 15).toStringAsFixed(2)}',
                      languageService,
                      isBold: true),
                ],
              );
            },
          ),
          SizedBox(height: 30.h),
          Text(
            languageService.getString('payment_method'),
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10.h),
          _buildPaymentOption(languageService.getString('cash_on_delivery')),
          _buildPaymentOption(languageService.getString('payfort')),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeliveryAddress()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF5E9B5),
                padding: EdgeInsets.symmetric(vertical: 15.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                languageService.getString('place_order'),
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String price, LanguageService languageService,
      {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 18.sp : 16.sp,
            ),
          ),
          Text(
            price,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 18.sp : 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String method) {
    return GestureDetector(
      onTap: () => setState(() => selectedPaymentMethod = method),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: selectedPaymentMethod == method
                ? Color(0xFFF5E9B5)
                : Colors.transparent,
            width: 1.w,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              method,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Icon(
              selectedPaymentMethod == method
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: Color(0xFFF5E9B5),
              size: 20.w,
            ),
          ],
        ),
      ),
    );
  }
}

class FavouriteItemCard extends StatefulWidget {
  final Map<String, dynamic> item;
  final LanguageService languageService;

  const FavouriteItemCard({
    Key? key,
    required this.item,
    required this.languageService,
  }) : super(key: key);

  @override
  State<FavouriteItemCard> createState() => _FavouriteItemCardState();
}

class _FavouriteItemCardState extends State<FavouriteItemCard> {
  late int count;

  @override
  void initState() {
    super.initState();
    count = (widget.item['quantity'] as int?) ?? 1;
  }

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final price = _parseDouble(widget.item['price']) ?? 0.0;
    final mrp = _parseDouble(widget.item['mrp']) ?? 1.0;
    final discountPercentage =
        mrp > 0 ? ((1 - price / mrp) * 100).toStringAsFixed(0) : '0';

    return Container(
      height: 113.h,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0808),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xDBFCF8E8), width: 1.w),
      ),
      child: Row(
        children: [
          Container(
            width: 121.w,
            height: 113.h,
            decoration: BoxDecoration(
              color: Color(0xF4CCC9BC),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: widget.item['image'] != null
                ? Image.asset(
                    widget.item['image'] as String,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                        'assets/placeholder.png',
                        fit: BoxFit.contain),
                  )
                : Image.asset('assets/placeholder.png', fit: BoxFit.contain),
          ),
          SizedBox(width: 18.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 9.h),
                Text(
                  widget.item['name'] as String? ??
                      widget.languageService.getString('no_name'),
                  style: GoogleFonts.poppins(
                    color: Color(0xFFFCF8E8),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text(
                      '${widget.languageService.getString('mrp')} ₹${mrp.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        color: Color(0xCEB4B2A9),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(width: 40.w),
                    Text(
                      '₹${price.toStringAsFixed(0)}',
                      style: GoogleFonts.poppins(
                        color: Color(0xFFFCF8E8),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Text(
                  '$discountPercentage% ${widget.languageService.getString('discount_20_off').split(' ').last}',
                  style: GoogleFonts.poppins(
                    color: Color(0xCE7FFC83),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 38.h,
            width: 90.w,
            decoration: BoxDecoration(
              color: Color(0xFFEFECE1),
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (count > 1) {
                      setState(() => count--);
                      // _updateQuantity(context);
                    }
                  },
                  child: Icon(
                    Icons.remove,
                    color: Colors.black,
                    size: 20.w,
                  ),
                ),
                Spacer(),
                Text(
                  '$count',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() => count++);
                    // _updateQuantity(context);
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 20.w,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
    );
  }

  double? _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}