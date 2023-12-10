import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';

class PromosList extends StatefulWidget {
  const PromosList({super.key});

  @override
  State<PromosList> createState() => _PromosListState();
}

class _PromosListState extends State<PromosList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Still looking?'),
                TextButton(
                  onPressed: () {
                    context.pushNamed('BrowseMap');
                  },
                  child: Text('Browse Map'),
                ),
              ],
            ),
            promos(
              'assets/images/car_rental.jpg',
              'Car Rentals',
              '\₱1234/day',
              'Embark on a journey of freedom and exploration with our premium car rental service. Drive in style and comfort as you navigate through scenic landscapes, making every road a memorable adventure.',
            ),
            promos(
              'assets/images/Boracay_White_Beach.png',
              'Boracay Beach',
              '\₱999/night',
              'Escape to the idyllic shores of Boracay and indulge in a luxurious retreat at our beachfront oasis, the ultimate destination for your tropical paradise getaway.',
            ),
            promos(
              'assets/images/Palawan.jpg',
              'El Nido, Palawan',
              '\₱999/night',
              'Immerse yourself in the tropical paradise of El Nido, Palawan. Indulge in the serenity of our luxurious accommodations, providing the perfect haven for your dream island getaway.',
            ),
          ].divide(
            SizedBox(
              height: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget promos(String image, String title, String price, String description) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                image,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  description,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      textAlign: TextAlign.end,
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF57636C),
                      size: 24,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
