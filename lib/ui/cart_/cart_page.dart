import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modern_grocery/bloc/GetAllUserCart/bloc/get_all_user_cart_bloc.dart';
import 'package:modern_grocery/repositery/api/getAllUserCart_api.dart';
import 'package:modern_grocery/repositery/model/getAllUserCart_model.dart';
import 'package:modern_grocery/ui/delivery/delivery_address.dart';

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
    context.read<GetAllUserCartBloc>().add(fetchGetAllUserCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0A0909),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: const [
                SizedBox(width: 40),
                BackButton(color: Color(0xffFCF8E8)),
              ],
            ),
            const SizedBox(height: 40),
            const Center(
              child: Text(
                'Cart',
                style: TextStyle(
                  color: Color(0xFFFCF8E8),
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.24,
                ),
              ),
            ),
            BlocBuilder<GetAllUserCartBloc, GetAllUserCartState>(
              builder: (context, state) {
                if (state is GetAllUserCartLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetAllUserCartLoaded) {
                  final cartModel =
                      context.read<GetAllUserCartBloc>().getAllUserCartModel;

                  // Check if cart model is null or cart items are empty
                  if (cartModel == null ||
                      cartModel.data == null ||
                      cartModel.data?.allCartItems == null ||
                      cartModel.data!.allCartItems!.isEmpty) {
                    return const Center(
                      child: Text(
                        'Your cart is empty',
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                    );
                  }

                  final cartItems = cartModel.data?.allCartItems!;
                  return SizedBox(
                    height: 120 * cartItems!.length.toDouble(),
                    child: Column(
                      children: cartItems.map((item) {
                        return FavouriteItemCard(item: {
                          'name': item.productId ?? 'Unknown Item',
                          'image': item.quantity ?? 'assets/placeholder.png',
                          'price': item.unit ?? 0.0,
                          'mrp': item.quantity ?? item.totalAmount ?? 0.0,
                        });
                      }).toList(),
                    ),
                  );
                } else if (state is GetAllUserCartError) {
                  return const Center(
                    child: Text(
                      'Error loading cart items',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            _buildCheckoutSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Promo code',
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: const TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF5E9B5),
                ),
                child: const Text('Apply'),
              ),
            ],
          ),
          const SizedBox(height: 30),
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
                  _buildPriceRow('Price', '₹${totalPrice.toStringAsFixed(2)}'),
                  _buildPriceRow('Discount', '₹5.00'),
                  _buildPriceRow('Delivery Charge', '₹20.00'),
                  const Divider(color: Colors.white70),
                  _buildPriceRow(
                      'Grand Total', '₹${(totalPrice + 15).toStringAsFixed(2)}',
                      isBold: true),
                ],
              );
            },
          ),
          const SizedBox(height: 30),
          const Text('Payment Method',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          const SizedBox(height: 10),
          _buildPaymentOption('Cash on Delivery'),
          _buildPaymentOption('Payfort'),
          const SizedBox(height: 20),
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
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text('Place Order',
                  style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String price, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: isBold ? 18 : 16)),
          Text(price,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: isBold ? 18 : 16)),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String method) {
    return GestureDetector(
      onTap: () => setState(() => selectedPaymentMethod = method),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedPaymentMethod == method
                ? Color(0xFFF5E9B5)
                : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(method,
                style: const TextStyle(color: Colors.white, fontSize: 16)),
            Icon(
              selectedPaymentMethod == method
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: Color(0xFFF5E9B5),
            ),
          ],
        ),
      ),
    );
  }
}

class FavouriteItemCard extends StatefulWidget {
  final Map<String, dynamic> item;

  const FavouriteItemCard({Key? key, required this.item}) : super(key: key);

  @override
  State<FavouriteItemCard> createState() => _FavouriteItemCardState();
}

class _FavouriteItemCardState extends State<FavouriteItemCard> {
  late int count;

  @override
  void initState() {
    super.initState();
    count =
        (widget.item['quantity'] as int?) ?? 1; // Initialize with item quantity
  }

  @override
  Widget build(BuildContext context) {
    // Parse price and mrp, handling String or null cases
    final price = _parseDouble(widget.item['price']) ?? 0.0;
    final mrp =
        _parseDouble(widget.item['mrp']) ?? 1.0; // Avoid division by zero
    final discountPercentage =
        mrp > 0 ? ((1 - price / mrp) * 100).toStringAsFixed(0) : '0';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0808),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xDBFCF8E8)),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xF4CCC9BC),
              borderRadius: BorderRadius.circular(8),
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
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item['name'] as String? ?? 'Unknown Item',
                  style: const TextStyle(
                    color: Color(0xFFFCF8E8),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'MRP ₹${mrp.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Color(0xCEB4B2A9),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '$discountPercentage% OFF',
                  style: const TextStyle(
                    color: Color(0xCE7FFC83),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '₹${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Color(0xFFFCF8E8),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _quantityButton('-', () {
                if (count > 1) {
                  setState(() => count--);
                  // _updateQuantity(context);
                }
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      color: Color(0xffFFFFFF),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              _quantityButton('+', () {
                setState(() => count++);
                // _updateQuantity(context);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quantityButton(String text, VoidCallback onPressed) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      child: IconButton(
        icon: Text(
          text,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: onPressed,
      ),
    );
  }

  // void _updateQuantity(BuildContext context) {
  //   context.read<GetAllUserCartBloc>().add(
  //         UpdateCartItemQuantityEvent(
  //           productId: widget.item['name'] as String,
  //           quantity: count,
  //         ),
  //       );
  // }

  double? _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
