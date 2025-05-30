import 'package:firstgetxapp/app/models/faq_model.dart';
import 'package:get/get.dart';

class FaqController extends GetxController {
  var searchQuery = ''.obs;

  final List<FaqItem> allFaqs = [
    FaqItem(
      category: 'Carte SIM',
      question: 'Comment achter une carte SIM virtuelles?',
      answer:
          'Il suffit de créer un compte, choisir une categorie, puis vérifier votre identité par reconnaissance faciale et lecture NFC de votre carte d’identité. Une fois validé, votre demende SIM virtuelle est enregistrée immédiatement.',
    ),
    FaqItem(
      category: 'Carte SIM',
      question: 'Que faire si ma SIM ne fonctionne pas ?',
      answer:
          'Vérifiez que l’activation a bien été confirmée. Si le problème persiste, contactez notre support via l’application pour une assistance rapide.',
    ),
    FaqItem(
      category: 'eSIM',
      question: 'Comment acheter des offres pour ma carte SIM virtuelle ?',
      answer:
          'Après avoir activé votre carte SIM virtuelle, rendez-vous dans la section « Offres » de l’application, choisissez l’offre qui vous convient, puis l’application vous redirige vers DjezzyApp, où vous pouvez compléter votre paiement sécurisé. L’offre sera automatiquement appliquée à votre carte SIM.',
    ),
    FaqItem(
      category: 'eSIM',
      question: 'Quels appareils sont compatibles eSIM ?',
      answer:
          'Les smartphones récents (iPhone, Samsung, Pixel…), ainsi que certaines tablettes et montres connectées. Vérifiez la compatibilité dans les paramètres de votre appareil',
    ),
    FaqItem(
      category: 'NFC',
      question: 'Comment activer le NFC ?',
      answer:
          'Allez dans les paramètres de votre téléphone, puis activez la fonction NFC dans les connexions sans fil.',
    ),
    FaqItem(
      category: 'NFC',
      question: 'À quoi sert le NFC ?',
      answer:
          'Le NFC permet d’échanger des données à courte distance, utilisé pour les paiements mobiles, le jumelage d’appareils, ou la lecture de tags NFC.',
    ),
    FaqItem(
      category: 'Inscription',
      question: 'Je n’arrive pas à valider mon inscription',
      answer:
          'Vérifiez que toutes les informations requises sont correctes, que vous avez une connexion internet stable, puis réessayez. Contactez le support si le problème persiste.',
    ),
  ];

  List<String> get categories {
    return allFaqs.map((f) => f.category).toSet().toList();
  }

  List<FaqItem> filteredFaqs(String category) {
    return allFaqs
        .where((faq) =>
            faq.category == category &&
            faq.question
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }
}
