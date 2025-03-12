class Project {
  final String name;
  final ProjectType type;
  final List<String> links;
  final String language;
  final String ide;
  final String image;
  final String detail;

  const Project(
    this.name,
    this.type,
    this.links,
    this.language,
    this.ide,
    this.image,
    this.detail,
  );

  factory Project.fromJson(Map<String, dynamic> json) {
    final linkString = json['links'] as String;
    final links = linkString.split('\n');
    return Project(
      json['name'],
      ProjectType.values.byName(json['type']),
      links,
      json['language'],
      json['ide'],
      json['image'],
      json['detail'],
    );
  }
}

enum ProjectType { personal, work, learning }
