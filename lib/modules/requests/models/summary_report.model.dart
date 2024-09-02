class SummaryReportModel {
  final String? year;
  final String? month;
  final String? duration;

  SummaryReportModel({
    this.year,
    this.month,
    this.duration,
  });

  factory SummaryReportModel.fromJson(Map<String, dynamic> json) {
    return SummaryReportModel(
      year: json['year'] as String?,
      month: json['month'] as String?,
      duration: json['duration'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'month': month,
      'duration': duration,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SummaryReportModel &&
        other.year == year &&
        other.month == month &&
        other.duration == duration;
  }

  @override
  int get hashCode => year.hashCode ^ month.hashCode ^ duration.hashCode;

  @override
  String toString() =>
      'DateDuration(year: $year, month: $month, duration: $duration)';

  SummaryReportModel copyWith({
    String? year,
    String? month,
    String? duration,
  }) {
    return SummaryReportModel(
      year: year ?? this.year,
      month: month ?? this.month,
      duration: duration ?? this.duration,
    );
  }
}
