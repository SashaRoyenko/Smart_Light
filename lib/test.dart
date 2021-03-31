void main() {
  var firstValue = DateTime(2021, 3, 30, 22, 00, 50);
  var secondValue = DateTime(1970, 1, 1, 1, 3, 5);
  print(firstValue);
  print(secondValue);
  print('------------------');

  // DateTime();
  DateTime validity = firstValue.add(Duration(
    hours: secondValue.hour,
    minutes: secondValue.minute,
    seconds: secondValue.second,
  ));
  DateTime current = DateTime(2021, 3, 30, 23, 0, 50);

  print(validity.subtract(Duration(
    hours: current.hour,
    minutes: current.minute,
    seconds: current.second,
  )));

  print('-----------------');
  print(firstValue);
  print(secondValue);
  print(validity);


}
