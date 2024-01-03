class UserTrait {
  String key;
  String? value;

  UserTrait(this.key, dynamic value) {
    if (value is DateTime) {
      this.value = formatDateToTimeZoneIso(value);
    } else if (value != null) {
      this.value = value.toString();
    } else {
      this.value = null;
    }
  }

  String formatDateToTimeZoneIso(DateTime date) {
    var offset = date.timeZoneOffset.inMinutes;
    var offsetHours = (offset.abs() / 60).floor();
    var offsetMinutes = offset.abs() % 60;
    var offsetSign = date.timeZoneOffset.isNegative ? "-" : "+";
    return "${date.toIso8601String().substring(0, 19)}$offsetSign${offsetHours.toString().padLeft(2, '0')}:${offsetMinutes.toString().padLeft(2, '0')}";
  }
}
