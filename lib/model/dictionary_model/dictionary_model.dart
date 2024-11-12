class DictionaryModel {
  String word;
  String phonetic;
  List<Phonetic> phonetics;
  List<Meaning> meanings;
  License license;
  List<String> sourceUrls;

  DictionaryModel({
    required this.word,
    required this.phonetic,
    required this.phonetics,
    required this.meanings,
    required this.license,
    required this.sourceUrls,
  });

  factory DictionaryModel.fromJson(Map<String, dynamic> json) {
    return DictionaryModel(
      word: json['word'] ?? '',
      phonetic: json['phonetic'] ?? '',
      phonetics: (json['phonetics'] as List)
          .map((phonetic) => Phonetic.fromJson(phonetic))
          .toList(),
      meanings: (json['meanings'] as List)
          .map((meaning) => Meaning.fromJson(meaning))
          .toList(),
      license: License.fromJson(json['license']),
      sourceUrls: List<String>.from(json['sourceUrls'] ?? []),
    );
  }
}

class License {
  String name;
  String url;

  License({
    required this.name,
    required this.url,
  });

  factory License.fromJson(Map<String, dynamic> json) {
    return License(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

class Meaning {
  String partOfSpeech;
  List<Definition> definitions;
  List<String> synonyms;
  List<String> antonyms;

  Meaning({
    required this.partOfSpeech,
    required this.definitions,
    required this.synonyms,
    required this.antonyms,
  });

  factory Meaning.fromJson(Map<String, dynamic> json) {
    return Meaning(
      partOfSpeech: json['partOfSpeech'] ?? '',
      definitions: (json['definitions'] as List)
          .map((definition) => Definition.fromJson(definition))
          .toList(),
      synonyms: List<String>.from(json['synonyms'] ?? []),
      antonyms: List<String>.from(json['antonyms'] ?? []),
    );
  }
}

class Definition {
  String definition;
  List<String> synonyms;
  List<String> antonyms;
  String? example;

  Definition({
    required this.definition,
    required this.synonyms,
    required this.antonyms,
    this.example,
  });

  factory Definition.fromJson(Map<String, dynamic> json) {
    return Definition(
      definition: json['definition'] ?? '',
      synonyms: List<String>.from(json['synonyms'] ?? []),
      antonyms: List<String>.from(json['antonyms'] ?? []),
      example: json['example'],
    );
  }
}

class Phonetic {
  String text;
  String audio;
  String? sourceUrl;

  Phonetic({
    required this.text,
    required this.audio,
    this.sourceUrl,
  });

  factory Phonetic.fromJson(Map<String, dynamic> json) {
    return Phonetic(
      text: json['text'] ?? '',
      audio: json['audio'] ?? '',
      sourceUrl: json['sourceUrl'],
    );
  }
}
