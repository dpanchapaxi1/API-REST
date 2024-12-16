import 'package:flutter/material.dart';
import '../controllers/dog_controller.dart';
import '../models/dog_models.dart';

class DogView extends StatefulWidget {
  @override
  _DogViewState createState() => _DogViewState();
}

class _DogViewState extends State<DogView> {
  final DogController _controller = DogController();
  final List<DogModel> _dogs = [];
  final TextEditingController _nameController = TextEditingController();

  // Método para agregar un perro con imagen de la API
  Future<void> _addDogFromApi() async {
    String name = _nameController.text.trim();
    if (name.isEmpty) {
      _showError('Por favor, ingresa el nombre del perro.');
      return;
    }

    try {
      DogModel fetchedDog = await _controller.fetchDogImage();
      setState(() {
        fetchedDog.name = name;
        _dogs.add(fetchedDog);
        _nameController.clear();
      });
    } catch (e) {
      _showError('Error al obtener imagen del perro: $e');
    }
  }

  // Método para eliminar un perro
  void _removeDog(int index) {
    setState(() {
      _dogs.removeAt(index);
    });
  }

  // Método para editar el nombre de un perro
  void _editDogName(int index) {
    _nameController.text = _dogs[index].name;  // Pre-llenar el campo con el nombre actual
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Nombre del Perro'),
        content: TextField(
          controller: _nameController,
          decoration: InputDecoration(hintText: 'Nuevo nombre del perro'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              String newName = _nameController.text.trim();
              if (newName.isEmpty) {
                _showError('Por favor, ingresa un nombre válido.');
                return;
              }
              setState(() {
                _dogs[index].name = newName;  // Actualizar el nombre del perro
                _nameController.clear(); // Limpiar el campo de texto
              });
              Navigator.pop(context);  // Cerrar el cuadro de diálogo
            },
            child: Text('Guardar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context), // Cerrar el cuadro de diálogo
            child: Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  // Mostrar errores
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[900], // Fondo negriazul
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Centrar la entrada del nombre
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: Container(
                    width: 300,
                    child: TextField(
                      controller: _nameController,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white), // Texto blanco
                      decoration: InputDecoration(
                        labelText: 'Nombre del perro',
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Botón con estilo celeste
              ElevatedButton(
                onPressed: _addDogFromApi,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan, // Botón celeste
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text(
                  'Agregar Perro desde API',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),

              SizedBox(height: 20),

              // Lista de perros
              Expanded(
                child: _dogs.isEmpty
                    ? Center(
                  child: Text(
                    'No hay perros aún. Agrega uno.',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
                    : ListView.builder(
                  itemCount: _dogs.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.blueGrey[800],
                      child: ListTile(
                        leading: Image.network(
                          _dogs[index].imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          _dogs[index].name,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'ID: ${_dogs[index].id}',
                          style: TextStyle(color: Colors.white70),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.yellow),
                              onPressed: () => _editDogName(index), // Editar nombre
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeDog(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
