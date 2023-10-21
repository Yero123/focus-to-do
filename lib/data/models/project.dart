class Project {
  final String id;
  final String name;
  final int color;
  Project({
    required this.id,
    required this.name,
    required this.color,
  });
  //toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
    };
  }

  //fromJson
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      color: json['color'],
    );
  }
}
