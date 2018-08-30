import 'package:imei_validator/imei_validator.dart';

main(List<String> arguments) {
  String Imei = "378282246310005";

  var validator = new ImeiValidator(Imei);
  print(validator);
  int meid = 37828224631300;

  var validator2 = new ImeiValidator.Integer(meid);
  print(validator2.Imei);
  print(validator2.isValid);
  print(validator2.checkDigit);
  print(validator2.toJson());
}
