import 'package:firstgetxapp/app/models/faq_model.dart';
import 'package:get/get.dart';

class FaqController extends GetxController {
  var searchQuery = ''.obs;

  final List<FaqItem> allFaqs = [
    FaqItem(category: 'Carte SIM', question: 'Comment activer ma carte SIM ?'),
    FaqItem(category: 'Carte SIM', question: 'Que faire si ma SIM ne fonctionne pas ?'),
    FaqItem(category: 'eSIM', question: 'Comment installer une eSIM ?'),
    FaqItem(category: 'eSIM', question: 'Quels appareils sont compatibles eSIM ?'),
    FaqItem(category: 'NFC', question: 'Comment activer le NFC ?'),
    FaqItem(category: 'NFC', question: 'À quoi sert le NFC ?'),
    FaqItem(category: 'Inscription', question: 'Je n’arrive pas à valider mon inscription'),
  ];

  List<String> get categories {
    return allFaqs.map((f) => f.category).toSet().toList();
  }

  List<FaqItem> filteredFaqs(String category) {
    return allFaqs.where((faq) =>
        faq.category == category &&
        faq.question.toLowerCase().contains(searchQuery.value.toLowerCase())
    ).toList();
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }
}
