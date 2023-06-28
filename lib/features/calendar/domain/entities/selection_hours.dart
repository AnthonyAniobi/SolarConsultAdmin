class SelectionHours {
  final int index;
  bool selected;

  SelectionHours(this.index, this.selected);

  String get hour {
    if (index == 0) {
      return "12 am";
    } else if (index < 12) {
      return "$index am";
    } else if (index == 12) {
      return "$index noon";
    } else {
      return "${index - 12} pm";
    }
  }
}
