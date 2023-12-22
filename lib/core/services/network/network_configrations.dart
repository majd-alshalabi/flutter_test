class NetworkConfigurations {
  static const kRegisterPath = 'register';
  static const kLoginPath = 'login';

  static const kGetProducts = 'products';
  static const kGetComments = 'comment';
  static const kRateProduct = 'rate';
  static const kOrderProduct = 'orders';
  static const kFilterProduct = 'filter-products';

  static const String BaseUrl = "https://event-reg.app/flutter_test/api/";
  static const Map<String, String> BaseHeaders = {
    "accept": "application/json, */* ,charset=UTF-8",
    'Charset': 'utf-8',
    "Content-Type": "application/json",
  };
}
