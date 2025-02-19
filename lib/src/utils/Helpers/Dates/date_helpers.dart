class DateHelpers {
  static String getStartDate() {
    var date = DateTime.now();
    return "${date.toLocal().day}/${date.toLocal().month}/${date.toLocal().year}";
  }
}
