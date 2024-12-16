class DogModel {
  String id;
  String name;
  String imageUrl;

  DogModel({required this.id, required this.name, required this.imageUrl});

  factory DogModel.fromJson(Map<String, dynamic> json) {
    return DogModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'Dog', // Nombre por defecto porque la API no devuelve nombre
      imageUrl: json['message'],
    );
  }
}
