import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/utils/utils.dart';

class CarDetails extends StatefulWidget {
  final CarModel? car;
  const CarDetails({super.key, this.car});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  Widget imageCarousel() {
    final images = widget.car?.photoUrl;
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
      body: Column(
        children: [
          imageCarousel(),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        withCurrency(
                          Text(
                            '${widget.car?.price} / day',
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
                            context.pushNamed('Booking',
                                extra: {'car': widget.car});
                          },
                          child: Text('Rent now'),
                        ),
                      ],
                    ),
                    Chip(
                      label: Text(
                        widget.car!.availability!,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Available Dates',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                    '${DateFormat('MMM d').format(widget.car!.startDate!)} - ${DateFormat('MMM d').format(widget.car!.endDate!)}'),
                Text(
                  'Car owner',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(widget.car!.ownerName!),
              ].divide(
                SizedBox(
                  height: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
