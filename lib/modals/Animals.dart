import 'dart:typed_data';

class SubscriptionPlan {
  final String time;
  final String price;

  SubscriptionPlan({
    required this.time,
    required this.price,
  });
}

class SubscriptionPlanDB {
  final String time;
  final String price;
  final Uint8List image;

  SubscriptionPlanDB(
      {required this.time, required this.price, required this.image});

  factory SubscriptionPlanDB.fromData(Map data) {
    return SubscriptionPlanDB(
      time: data['time'],
      price: data['price'],
      image: data['image'],
    );
  }
}

class AnimalDB {
  final String name;
  final String desc;
  final Uint8List image;

  AnimalDB({
    required this.name,
    required this.desc,
    required this.image,
  });

  factory AnimalDB.fromData(Map data) {
    return AnimalDB(
        name: data['name'], desc: data['description'], image: data['image']);
  }
}
