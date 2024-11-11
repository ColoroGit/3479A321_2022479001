class Hollyday {
  String name;
  String date;
  bool irrenunciable;
  String type;

  Hollyday({
    required this.name,
    required this.date,
    required this.irrenunciable,
    required this.type,
  });

  factory Hollyday.fromJson(Map map) {
    return Hollyday(
      name: map['nombre'],
      date: map['fecha'],
      irrenunciable: (map['irrenunciable'] == "1"),
      type: map['tipo'],
    );
  }
}
