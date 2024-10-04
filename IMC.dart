import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Classe principal do aplicativo
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

// Tela principal
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controladores para pegar os valores de peso e altura
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  double? _resultadoIMC;

  // Função para calcular o IMC
  void _calcularIMC() {
    final double peso = double.tryParse(_pesoController.text) ?? 0.0;
    final double altura = double.tryParse(_alturaController.text) ?? 0.0;

    if (peso > 0 && altura > 0) {
      setState(() {
        _resultadoIMC = peso / (altura * altura);
      });
    } else {
      setState(() {
        _resultadoIMC = null;
      });
    }
  }

  // Função para exibir o resultado de acordo com o IMC calculado
  String _exibirResultadoIMC(double? imc) {
    if (imc == null) return "Preencha os campos corretamente";
    if (imc < 18.5) return "Abaixo do peso (${imc.toStringAsFixed(2)})";
    if (imc >= 18.5 && imc < 24.9)
      return "Peso normal (${imc.toStringAsFixed(2)})";
    if (imc >= 25 && imc < 29.9) return "Sobrepeso (${imc.toStringAsFixed(2)})";
    return "Obesidade (${imc.toStringAsFixed(2)})";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _pesoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _alturaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Altura (m)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calcularIMC,
              child: Text('Calcular IMC'),
            ),
            SizedBox(height: 24),
            Text(
              _exibirResultadoIMC(_resultadoIMC),
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
