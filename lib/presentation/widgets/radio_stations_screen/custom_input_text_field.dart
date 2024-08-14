import 'package:flutter/material.dart';
import 'package:radio_app/presentation/providers/radio_station_provider.dart';

class CustomInputTextField extends StatelessWidget {
  const CustomInputTextField({
    super.key,
    required TextEditingController controller,
    required this.provider,
  }) : _controller = controller;

  final TextEditingController _controller;
  final RadioStationProvider provider;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        filled: true,
        hintText: 'Type the genre',
        suffixIcon:  IconButton(
          icon: const Icon(Icons.search),
          iconSize: 40,
          onPressed: () {
            if (_controller.text.isEmpty) return;     // No realiza ninguna accion si no se ingresa ningun genero musical
            provider.fetchRadioStations(_controller.text);
            FocusScope.of(context).unfocus(); // oculta teclado
          },
        ),
     
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      onSubmitted: (value){        // Asigna la misma funcion del boton buscar al boton enter del teclado
        if (_controller.text.isEmpty) return; 
        provider.fetchRadioStations(_controller.text);
        FocusScope.of(context).unfocus();
      },
    );
  }
}



