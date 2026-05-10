class IdGenerator {
  const IdGenerator._();

  static int generate() => DateTime.now().microsecondsSinceEpoch;
}
