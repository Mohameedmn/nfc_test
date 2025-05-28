class FaqItem {
  final String category;
  final String question;
  final String answer; // optional if needed later

  FaqItem({
    required this.category,
    required this.question,
    this.answer = '',
  });
}
