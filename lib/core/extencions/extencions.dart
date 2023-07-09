extension TimerVideo on Duration {
  String get timeVideo {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final String hours = twoDigits(inHours);
    final String minutes = twoDigits(inMinutes.remainder(60));
    final String seconds = twoDigits(inSeconds.remainder(60));

    return [
      if (inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }
}

extension DateFormatBR on DateTime {
  String get dateFormatBR {
    final String day = this.day.toString();
    final String month = this.month.toString();
    final String year = this.year.toString();
    return [
      day,
      month,
      year,
    ].join('/');
  }
}
