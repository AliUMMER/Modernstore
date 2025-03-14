import 'package:flutter/material.dart';
import 'package:modern_grocery/ui/delivery_address.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<Map<String, dynamic>> favourites = [
    {'name': 'Banana', 'image': 'assets/Banana.png', 'price': 80, 'mrp': 100},
    {'name': 'Carrot', 'image': 'assets/Carrot.png', 'price': 80, 'mrp': 100},
    {'name': 'Onion', 'image': 'assets/Onion.png', 'price': 80, 'mrp': 100},
    {'name': 'Papaya', 'image': 'assets/Pappaya.png', 'price': 80, 'mrp': 100},
    {'name': 'Potato', 'image': 'assets/Potato.png', 'price': 80, 'mrp': 100},
    {'name': 'Tomato', 'image': 'assets/Tomato.png', 'price': 80, 'mrp': 100},
    {'name': 'Orange', 'image': 'assets/Orange.png', 'price': 80, 'mrp': 100},
  ];

  String selectedPaymentMethod = 'Cash on Delivery';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0A0909),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // const SizedBox(height: 63),
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
            SizedBox(
              height: 120 * 7,
              // MediaQuery.of(context).size.height - 250, // Adjust as needed
              child: Column(
                children: favourites.map((item) {
                  return FavouriteItemCard(item: item);
                }).toList(),
              ),
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
          // Promo Code Section
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

          // Price Details
          _buildPriceRow('Price', '₹630.00'),
          _buildPriceRow('Discount', '₹5.00'),
          _buildPriceRow('Delivery Charge', '₹20.00'),
          const Divider(color: Colors.white70),
          _buildPriceRow('Grand Total', '₹725', isBold: true),
          const SizedBox(height: 30),

          // Payment Method
          const Text('Payment Method',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          const SizedBox(height: 10),
          _buildPaymentOption('Cash on Delivery'),
          _buildPaymentOption('Payfort'),
          const SizedBox(height: 20),

          // Place Order Button
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
                ? Color(0xFFF5E9B5)!
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
  int count = 1;

  @override
  Widget build(BuildContext context) {
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
            child: Image.asset(widget.item['image'], fit: BoxFit.contain),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item['name'],
                  style: const TextStyle(
                    color: Color(0xFFFCF8E8),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'MRP ₹${widget.item['mrp']}',
                  style: const TextStyle(
                    color: Color(0xCEB4B2A9),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${((1 - widget.item['price'] / widget.item['mrp']) * 100).toStringAsFixed(0)}% OFF',
                  style: const TextStyle(
                    color: Color(0xCE7FFC83),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '₹${widget.item['price']}',
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
                setState(() {
                  if (count > 1) count--;
                });
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
                setState(() {
                  count++;
                });
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
}
