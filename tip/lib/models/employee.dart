class Employee {
  final String id;
  final String name;
  final String pictureUrl;
  final String workspace;
  final String? note;

  Employee({
    required this.id,
    required this.name,
    required this.pictureUrl,
    required this.workspace,
    this.note,
  });
}
