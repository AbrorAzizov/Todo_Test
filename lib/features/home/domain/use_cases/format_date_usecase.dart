class  FormatDateUseCase {
  String formatDate(DateTime date) {

    const months = [
      'января','февраля','марта','апреля','мая','июня',
      'июля','августа','сентября','октября','ноября','декабря'
    ];

    return '${date.day} ${months[date.month - 1]}';
  }

  bool isExpired (DateTime date) {
    final now = DateTime.now();
    if (date.isBefore(now)){
      return true;
    }else {
      return false;
    }
  }
}