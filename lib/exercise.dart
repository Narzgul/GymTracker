class Exercise {
  String name;
  int sets;
  int reps;
  double weight;
  String id;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.weight,
    required this.id,
  });

  @override
  bool operator ==(Object other) {
    return other is Exercise &&
        other.id == id &&
        other.name == name &&
        other.sets == sets &&
        other.reps == reps &&
        other.weight == weight;
  }

  @override
  int get hashCode => Object.hashAll([name, sets, reps, weight, id]);
}
