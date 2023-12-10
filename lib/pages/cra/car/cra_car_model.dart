import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/cra_controller.dart';

class CraCarModel {
  Widget? result;

  // FutureBuilder<List<CarModel>?> getCars(
  //     void Function(void Function()) setParentState) {
  //   return FutureBuilder(
  //     future: CraController.getCraCars(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState != ConnectionState.done)
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );

  //       List<CarModel>? cars = snapshot.data;
  //       if (cars == null)
  //         return Center(
  //           child: Text('No registered cars'),
  //         );

  //       return SingleChildScrollView(
  //         child: ListView.separated(
  //           shrinkWrap: true,
  //           itemCount: cars.length,
  //           physics: NeverScrollableScrollPhysics(),
  //           itemBuilder: (context, index) {
  //             final car = cars[index];
  //             return InkWell(
  //               onLongPress: () {
  //                 showDialog(
  //                   context: context,
  //                   builder: (context) {
  //                     return StatefulBuilder(
  //                       builder: (context, setState) {
  //                         return result ??
  //                             AlertDialog(
  //                               title: Text('Remove'),
  //                               titlePadding: EdgeInsets.only(
  //                                   left: 20, top: 20, right: 20),
  //                               contentPadding: EdgeInsets.all(20),
  //                               content:
  //                                   Text('Are you sure to remove this car?'),
  //                               actions: [
  //                                 TextButton(
  //                                   onPressed: () {
  //                                     result = deleteCar(
  //                                       car.licensePlate!,
  //                                       setParentState,
  //                                     );
  //                                     setState(() {});
  //                                   },
  //                                   child: Text('Remove'),
  //                                 ),
  //                                 TextButton(
  //                                   onPressed: () {
  //                                     context.pop();
  //                                   },
  //                                   child: Text('Cancel'),
  //                                 ),
  //                               ],
  //                             );
  //                       },
  //                     );
  //                   },
  //                 );
  //               },
  //               onTap: () {
  //                 context.pushNamed(
  //                   'CarDetails',
  //                   pathParameters: {'licensePlate': car.licensePlate!},
  //                   extra: <String, dynamic>{
  //                     'car': car,
  //                   },
  //                 );
  //               },
  //               child: CarItemWidget(car: car),
  //             );
  //           },
  //           separatorBuilder: (context, index) {
  //             return SizedBox(
  //               height: 10, // Adjust the height of the separator as needed
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<bool> delete(String licensePlate) async {
    return await CraController.deleteCar(licensePlate);
  }

  // FutureBuilder<String> deleteCar(
  //     String licensePlate, void Function(void Function()) setState) {
  //   return FutureBuilder(
  //     future: CraController.deleteCar(licensePlate),
  //     builder: (context, snapshot) {
  //       var content;
  //       if (snapshot.hasError) content = Text('Connection error');
  //       if (snapshot.connectionState != ConnectionState.done)
  //         CircularProgressIndicator();
  //       if (snapshot.hasData) content = Text(snapshot.data!);
  //       return AlertDialog(
  //         title: Text('Deleted'),
  //         content: content,
  //         actions: [
  //           if (snapshot.connectionState == ConnectionState.done)
  //             TextButton(
  //               onPressed: () {
  //                 setState(() {
  //                   result = null;
  //                 });
  //                 context.pop();
  //               },
  //               child: Text('Ok'),
  //             ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
