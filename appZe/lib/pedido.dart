import 'package:flutter/material.dart';

class Pedidos extends StatelessWidget {
  const Pedidos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushNamed('/incio');
              break;
            case 1:
              Navigator.of(context).pushNamed('/pedidos');
              break;
            case 2:
              Navigator.of(context).pushNamed('/carrinho');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/botaoinicio.png"),
              size: 50,
            ), // Ícone de home
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/botaopedidos.png"),
              size: 50,
            ), // Ícone de lista
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/botaocarrinho.png"),
              size: 50,
            ), // Ícone de carrinho
            label: '',
          ),
        ],
        backgroundColor: const Color(0xFF14C871), // Cor de fundo verde
        selectedItemColor: Colors.white,
        unselectedItemColor:
            Colors.white54, // Cores dos ícones quando não selecionados
        showSelectedLabels: true, // Exibe os rótulos dos itens selecionados
        showUnselectedLabels:
            true, // Exibe os rótulos dos itens não selecionados
      ),
    );
  }
}
