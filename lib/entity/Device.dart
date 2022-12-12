class Device {
  String id;
  String description;
  bool isSelected;

  Device(this.id, this.description, this.isSelected);

  Device.name({this.id, this.description, this.isSelected});

  static Device fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Device.name(
      id: json['id'],
      description: json['description'],
      isSelected: json['isSelected'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'isSelected': isSelected,
      };
}
