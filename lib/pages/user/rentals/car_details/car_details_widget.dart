import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/utils/utils.dart';

class CarDetails extends StatefulWidget {
  final CarModel car;
  const CarDetails({super.key, required this.car});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  Widget imageCarousel() {
    final images = widget.car.photoUrl;
    return Card(
      child: CarouselSlider.builder(
        itemCount: images?.length,
        options: CarouselOptions(
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
        ),
        itemBuilder: (context, index, viewIndex) {
          return CachedNetworkImage(
            imageUrl: getImageUrl(images![index]),
            errorWidget: (context, url, error) => Icon(
              Icons.error,
              color: Colors.red,
            ),
            placeholder: (context, url) => Center(
              child: const CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              imageCarousel(),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      withCurrency(
                        Text(
                          '${widget.car.price} / day',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      FilledButton(
                        onPressed: () {
                          context.pushNamed(
                            'Booking',
                            extra: widget.car,
                          );
                        },
                        child: Text('Rent now'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Available Dates',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        '${DateFormat('MMM d').format(widget.car.startDate)} - ${DateFormat('MMM d').format(widget.car.endDate)}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Car owner',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        widget.car.ownerName!,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  Divider(),
                  Text(
                    'Unavailable dates',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  ListView.builder(
                    itemCount: widget.car.schedule?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text(
                            '${DateFormat('MMM d').format(DateTime.parse(widget.car.schedule![index]['rentalStartDate']))} - ${DateFormat('MMM d').format(DateTime.parse(widget.car.schedule![index]['rentalEndDate']))}',
                          ),
                        ],
                      );
                    },
                  ),
                ].divide(
                  SizedBox(
                    height: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
