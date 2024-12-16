import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dog_models.dart';

class DogController {
  final String _dogApiUrl = 'https://dog.ceo/api/breeds/image/random';

  // Método para obtener una imagen de perro desde la API
  Future<DogModel> fetchDogImage() async {
    final response = await http.get(Uri.parse(_dogApiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return DogModel.fromJson(data);
    } else {
      throw Exception('Error al cargar imagen del perro');
    }
  }

  // Crear un perro localmente (solo para agregar a la lista)
  DogModel createDog(String name, String imageUrl) {
    String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
    return DogModel(id: uniqueId, name: name, imageUrl: imageUrl);
  }
}
