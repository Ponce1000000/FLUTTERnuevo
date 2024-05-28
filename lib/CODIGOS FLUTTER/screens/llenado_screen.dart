import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ticket_screen.dart'; // Asegúrate de importar la nueva pantalla

class LlenadoScreen extends StatefulWidget {
  @override
  _LlenadoScreenState createState() => _LlenadoScreenState();
}

class _LlenadoScreenState extends State<LlenadoScreen> {
  List<DocumentSnapshot> _selectedMarcaDocuments = [];
  List<DocumentSnapshot> _allMarcaDocuments = [];
  List<DocumentSnapshot> _selectedClienteDocuments = [];
  List<DocumentSnapshot> _allClienteDocuments = [];
  List<DocumentSnapshot> _selectedVendedorDocuments = [];
  List<DocumentSnapshot> _allVendedorDocuments = [];
  List<DocumentSnapshot> _selectedVehiculoDocuments = [];
  List<DocumentSnapshot> _allVehiculoDocuments = [];
  String? _selectedMarcaDescription;
  String? _selectedClienteName;
  String? _selectedVendedorName;
  String? _selectedVehiculo;

  @override
  void initState() {
    super.initState();
    _fetchMarcaDocuments();
    _fetchClienteDocuments();
    _fetchVendedorDocuments();
    _fetchVehiculoDocuments();
  }

  Future<void> _fetchMarcaDocuments() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Marca').get();
    setState(() {
      _allMarcaDocuments = querySnapshot.docs;
    });
  }

  Future<void> _fetchClienteDocuments() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Cliente').get();
    setState(() {
      _allClienteDocuments = querySnapshot.docs;
    });
  }

  Future<void> _fetchVendedorDocuments() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Vendedor').get();
    setState(() {
      _allVendedorDocuments = querySnapshot.docs;
    });
  }

  Future<void> _fetchVehiculoDocuments() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Vehiculo').get();
    setState(() {
      _allVehiculoDocuments = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Llenado Screen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Widget para seleccionar la Marca
          _buildMarcaComboBox(),
          // Widget para seleccionar el Cliente
          _buildClienteComboBox(),
          // Widget para seleccionar el Vendedor
          _buildVendedorComboBox(),
          // Widget para seleccionar el Vehículo
          _buildVehiculoComboBox(),
          Spacer(),
          // Botón para crear ticket
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TicketScreen(
                  marca: _selectedMarcaDescription,
                  cliente: _selectedClienteName,
                  vendedor: _selectedVendedorName,
                  vehiculo: _selectedVehiculo,
                )),
              );
            },
            child: Text('Crear Ticket'),
          ),
          SizedBox(height: 20), // Espacio adicional para que el botón no esté pegado al borde inferior
          // Botón para regresar
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Regresar al Formulario'),
          ),
        ],
      ),
    );
  }

  Widget _buildMarcaComboBox() {
    return DropdownButtonFormField<String>(
      value: _selectedMarcaDescription,
      items: _allMarcaDocuments.map((document) {
        return DropdownMenuItem<String>(
          value: document['Descripcion'],
          child: Text(document['Descripcion'] ?? ''),
        );
      }).toList(),
      hint: Text('Seleccione una marca'),
      onChanged: (value) {
        setState(() {
          _selectedMarcaDescription = value;
          _selectedMarcaDocuments = _allMarcaDocuments;
        });
      },
    );
  }

  Widget _buildClienteComboBox() {
    return DropdownButtonFormField<String>(
      value: _selectedClienteName,
      items: _allClienteDocuments.map((document) {
        return DropdownMenuItem<String>(
          value: document['Nombre'],
          child: Text(document['Nombre'] ?? ''),
        );
      }).toList(),
      hint: Text('Seleccione un cliente'),
      onChanged: (value) {
        setState(() {
          _selectedClienteName = value;
          _selectedClienteDocuments = _allClienteDocuments;
        });
      },
    );
  }

  Widget _buildVendedorComboBox() {
    return DropdownButtonFormField<String>(
      value: _selectedVendedorName,
      items: _allVendedorDocuments.map((document) {
        return DropdownMenuItem<String>(
          value: document['Nombre'],
          child: Text(document['Nombre'] ?? ''),
        );
      }).toList(),
      hint: Text('Seleccione un vendedor'),
      onChanged: (value) {
        setState(() {
          _selectedVendedorName = value;
          _selectedVendedorDocuments = _allVendedorDocuments;
        });
      },
    );
  }

  Widget _buildVehiculoComboBox() {
    return DropdownButtonFormField<String>(
      value: _selectedVehiculo,
      items: _allVehiculoDocuments.map((document) {
        final String color = document['color'];
        final dynamic modeloDynamic = document['modelo'];
        final dynamic precioDynamic = document['precio'];

        // Asegúrate de que modelo y precio sean del tipo correcto
        final int modelo = modeloDynamic is int ? modeloDynamic : int.tryParse(modeloDynamic.toString()) ?? 0;
        final double precio = precioDynamic is double ? precioDynamic : double.tryParse(precioDynamic.toString()) ?? 0.0;

        return DropdownMenuItem<String>(
          value: '$color, $modelo, \$${precio.toStringAsFixed(2)}',
          child: Text('$color, $modelo, \$${precio.toStringAsFixed(2)}'),
        );
      }).toList(),
      hint: Text('Seleccione un vehículo'),
      onChanged: (value) {
        setState(() {
          _selectedVehiculo = value;
          _selectedVehiculoDocuments = _allVehiculoDocuments;
        });
      },
    );
  }
}
