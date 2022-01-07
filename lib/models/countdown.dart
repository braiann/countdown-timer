class Countdown {
  int id;
  DateTime doneAt;
  String description;

  Countdown(
      {required this.id, required this.doneAt, required this.description});

  // Returns list of remaining [years, months, days, hours, minutes, seconds]
  // until doneAt date and time
  String getTimeLeft() {
    Duration remainder = doneAt.difference(DateTime.now());
    int days = remainder.inDays;
    String timeLeft = days != 0 ? '${days.abs()}d' : '';
    remainder = remainder - Duration(days: days);
    int hours = remainder.inHours;
    timeLeft += hours != 0 ? ' ${hours.abs()}h' : '';
    remainder = remainder - Duration(hours: hours);
    int minutes = remainder.inMinutes;
    timeLeft += minutes != 0 ? ' ${minutes.abs()}m' : '';
    remainder = remainder - Duration(minutes: minutes);
    int seconds = remainder.inSeconds;
    timeLeft += seconds != 0 ? ' ${seconds.abs()}s' : '';
    if (seconds > 0) {
      return timeLeft;
    } else {
      return '$timeLeft ago';
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'doneAt': doneAt.toString(),
        'description': description,
      };
}
