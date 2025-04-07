// THIS MODEL FOR PAYROLS THAT COMES FROM THE GET ALL PAYROLL API
class PayrollListItemModel {
  final int? id;
  final String? name;
  final String? date;

  PayrollListItemModel({this.id, this.name, this.date});

  // Factory constructor for creating an instance from a JSON map
  factory PayrollListItemModel.fromJson(Map<String, dynamic> json) {
    return PayrollListItemModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      date: json['date'] as String?,
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date,
    };
  }

  // Method to create a copy of an instance with optional new values
  PayrollListItemModel copyWith({
    int? id,
    String? name,
    String? date,
  }) {
    return PayrollListItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
    );
  }

  // Overriding the toString method for better debugging output
  @override
  String toString() {
    return 'PayrollListItemModel(id: $id, name: $name, date: $date)';
  }

  // Overriding equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PayrollListItemModel) return false;
    return other.id == id && other.name == name && other.date == date;
  }

  // Overriding the hashCode method
  @override
  int get hashCode => Object.hash(id, name, date);
}
