import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/models/cra_user_model.dart';

List<CarModel> mockCars() {
  return [
    CarModel(
      licensePlate: 'WYSIWYG',
      ownerName: 'Doe',
      ownerId: '1',
      vehicleType: 'Sedan',
      availability: 'Available',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      price: 1234,
      photoUrl: [''],
    ),
    CarModel(
      licensePlate: 'AWDFQW',
      ownerName: 'Doe',
      ownerId: '2',
      vehicleType: 'Sedan',
      availability: 'Available',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      price: 1234,
      photoUrl: [''],
    ),
    CarModel(
      licensePlate: 'ZXCVXVB',
      ownerName: 'Doe',
      ownerId: '3',
      vehicleType: 'Sedan',
      availability: 'On rent',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      price: 1234,
      photoUrl: [''],
    ),
  ];
}

CraUserModel mockCraUser() {
  return CraUserModel(
    id: '1',
    firstName: 'John',
    lastName: 'Doe',
    email: 'johndoe@gmail.com',
    contactNo: '0987654321',
    address: 'LLC',
    vehicles: mockCars(),
    rentals: [],
  );
}
