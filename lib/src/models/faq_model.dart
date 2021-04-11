class Informacion {
  String ask;
  String answer;
  List<Informacion> faq = [];

  Informacion({this.ask, this.answer});

  Informacion.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var resp in jsonList) {
      final info = new Informacion.fromJsonMap(resp);
      faq.add(info);
    }
  }

  Informacion.fromJsonMap(Map<String, dynamic> jsonMap) {
    ask = jsonMap['ask'];
    answer = jsonMap['answer'];
  }
}
