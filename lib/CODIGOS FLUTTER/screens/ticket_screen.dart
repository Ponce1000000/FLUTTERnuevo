import 'package:flutter/material.dart';

class TicketScreen extends StatelessWidget {
  final String? marca;
  final String? cliente;
  final String? vendedor;
  final String? vehiculo;

  TicketScreen({
    required this.marca,
    required this.cliente,
    required this.vendedor,
    required this.vehiculo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket de Renta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Marca: ${marca ?? 'No seleccionada'}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Cliente: ${cliente ?? 'No seleccionado'}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Vendedor: ${vendedor ?? 'No seleccionado'}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Vehículo: ${vehiculo ?? 'No seleccionado'}', style: TextStyle(fontSize: 16)),
            // Aquí puedes agregar más widgets o lógica según sea necesario
          ],
        ),
      ),
    );
  }
}
