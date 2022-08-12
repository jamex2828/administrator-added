class Item {
  String propertyNum;
  String description;
  String acquisitionDate;
  String estimatedLife;
  String officeDesignation;
  String serialNum;

  Item(
      {required this.propertyNum,
      required this.description,
      required this.acquisitionDate,
      required this.estimatedLife,
      required this.officeDesignation,
      required this.serialNum});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      propertyNum: json['property_no'],
      description: json['description'],
      acquisitionDate: json['acquisiton_date'],
      estimatedLife: json['estimated_life'],
      officeDesignation: json['office_designation'],
      serialNum: json['brand_serial_no'],
    );
  }

  get id => null;
}
class RequestState {
  const RequestState();
}

class RequestInitial extends RequestState {}

class RequestLoadInProgress extends RequestState {}

class RequestLoadSuccess extends RequestState {
  const RequestLoadSuccess(this.body);
  final String body;
}

class RequestLoadFailure extends RequestState {}
