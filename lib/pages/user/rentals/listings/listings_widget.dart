import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:joiner_1/components/cra/car_item_widget.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import 'package:provider/provider.dart';

class ListingsWidget extends StatefulWidget {
  const ListingsWidget({Key? key}) : super(key: key);

  @override
  _ListingsWidgetState createState() => _ListingsWidgetState();
}

class _ListingsWidgetState extends State<ListingsWidget> {
  Future<List<CarModel>?>? _fetchAvailableCars;
  TextEditingController _datesController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  DateTimeRange? _datePicked;

  @override
  void initState() {
    super.initState();
    _fetchAvailableCars =
        (context.read<Auth>() as UserController).getAvailableCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text('Rent a Car'),
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showDateRangePicker(
                          context: context,
                          firstDate: getCurrentTimestamp,
                          lastDate: DateTime(2050),
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              _datesController.text =
                                  '${DateFormat('MMM d').format(value.start)} - ${DateFormat('MMM d').format(value.end)}';
                            });

                            _datePicked = value;
                          }
                        });
                      },
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          inputDecorationTheme: Theme.of(context)
                              .inputDecorationTheme
                              .copyWith(
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                        ),
                        child: CustomTextInput(
                          hintText: 'Filter by dates',
                          controller: _datesController,
                          enabled: false,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomTextInput(
                      hintText: 'Filter by price',
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      inputFormatters: FilteringTextInputFormatter.digitsOnly,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _fetchAvailableCars =
                          (context.read<Auth>() as UserController)
                              .getAvailableCars(
                        dateFilter: _datePicked,
                        priceFilter: _priceController.text.trim().isNotEmpty
                            ? double.parse(_priceController.text)
                            : null,
                      );
                      setState(() {});
                    },
                    child: Icon(Icons.filter_alt_rounded),
                  ),
                ].divide(
                  SizedBox(
                    width: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: getAvailableCars(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<CarModel>?> getAvailableCars() {
    return FutureBuilder(
      future: _fetchAvailableCars,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (snapshot.data == null)
          return Center(
            child: Text('No available cars for today :('),
          );
        final cars = snapshot.data!;
        return SingleChildScrollView(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: cars.length,
            itemBuilder: (context, index) {
              return CarItemWidget(car: cars[index]);
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
          ),
        );
      },
    );
  }
}
