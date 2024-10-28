class DeviceInfo {
  final String operatingSystem;
  final String operatingSystemVersion;
  final String brand;
  final String deviceUniqueId;
  final String type;

  DeviceInfo({
    required this.operatingSystem,
    required this.operatingSystemVersion,
    required this.brand,
    required this.deviceUniqueId,
    required this.type,
  });

  factory DeviceInfo.fromMap(Map<String, dynamic> map) {
    return DeviceInfo(
      operatingSystem: map['operating_system'] as String? ??"",
      operatingSystemVersion: map['operating_system_version'] as String? ??"",
      brand: map['brand'] as String? ??"",
      deviceUniqueId: map['device_unique_id'] as String? ??"",
      type: map['type'] as String? ??"",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'operating_system': operatingSystem,
      'operating_system_version': operatingSystemVersion,
      'brand': brand,
      'device_unique_id': deviceUniqueId,
      'type': type,
    };
  }

  @override
  bool operator ==(covariant DeviceInfo other) {
    if (identical(this, other)) return true;

    return other.operatingSystem == operatingSystem &&
        other.operatingSystemVersion == operatingSystemVersion &&
        other.brand == brand &&
        other.deviceUniqueId == deviceUniqueId &&
        other.type == type;
  }

  @override
  int get hashCode {
    return operatingSystem.hashCode ^
        operatingSystemVersion.hashCode ^
        brand.hashCode ^
        deviceUniqueId.hashCode ^
        type.hashCode;
  }
}
