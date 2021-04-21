class DecorateTime {
  DecorateTime(this.timestamp);
  int timestamp;

  String decorate() {
    var timeNow = DateTime.now();
    var substract = timeNow
        .subtract(Duration(days: 719528, milliseconds: timestamp + 3600000))
        .toIso8601String();
    int days = int.parse(substract[9]) - 1;
    int hours = int.parse(substract.substring(11, 13));
    int minutes = int.parse(substract.substring(14, 16));
    if (days > 0) {
      if (days == 1) return '1 dzień temu';
      return '$days dni temu';
    } else if (hours > 0) {
      if (hours == 1)
        return '1 godzina temu';
      else if (hours > 1 && hours < 5) return '$hours godziny temu';
      return '$hours godzin temu';
    } else {
      if (minutes <= 1)
        return '1 minuta temu';
      else if (minutes > 1 && minutes < 5) return '$minutes minuty temu';
      return '$minutes minut temu';
    }
  }
}
