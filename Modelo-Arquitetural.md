# <center> Projeto de Sistemas - Zé Menu </center>

---
## <center> Modelo Arquitetural </center>

## Tecnologias
Neste projeto usaremos algumas tecnologias: Dart(especificamente o flutter), MySQL, Figma e Trello.

### 1. Dart/Flutter
Dart é uma linguagem de programação desenvolvida pela Google. É uma linguagem orientada a objetos, com uma sintaxe que lembra bastante outras linguagens como JavaScript, C# e Java. Dart foi projetada para ser simples e eficiente, oferecendo uma boa performance tanto em dispositivos móveis quanto na web. <br>
<br>
Flutter é um framework que utiliza Dart para construir aplicativos móveis, web e desktop com uma única base de código. Ele é conhecido por permitir o desenvolvimento rápido com widgets customizáveis e uma renderização altamente eficiente.

### 2. MySQL
MySQL é um sistema de gerenciamento de banco de dados relacional (RDBMS) de código aberto. Ele é usado para armazenar, organizar e acessar dados em tabelas, sendo amplamente utilizado em aplicações web para gerenciar grandes volumes de informações.

### 3. Figma
Figma é uma ferramenta de design colaborativa baseada na nuvem, usada principalmente para criar interfaces de usuário (UI) e protótipos. Ela permite que várias pessoas trabalhem juntas em tempo real, facilitando o desenvolvimento de projetos de design e colaboração entre equipes.

### 4. Trello
Trello é uma ferramenta de gerenciamento de projetos que utiliza quadros (boards) e cartões (cards) para organizar tarefas e fluxos de trabalho. É popular por sua interface simples e flexível, permitindo que equipes rastreiem o progresso de projetos e colaborem de maneira visual.

---
## Diagrama Arquitetural
Diagrama com intuito de estruturar os principais componentes técnicos e como eles interagem para suportar as funcionalidades descritas: 
<br>
<br>
![Diagrama Arquitetural](https://github.com/user-attachments/assets/2a00b4e2-7c1d-4c3e-ad21-fa1a8b1ee93c)

---
## Padrões
1. Variáveis devem seguir a convenção de nomenclatura camelCase

2. Arquivos devem seguir a convenção de nomenclatura Snake Case
3. Estruturação de arquivos através do gerenciador de pacotes e templates Slidy
4. Testes unitários serão feitos com o pacote do próprio dart (test)

---
## Implementação/Exemplos
Exemplo Camada de Apresentação:
```
Expanded(
            child: ListView(
              children: const [
                ProductCard(
                  title: 'X Tudo',
                  description:
                      'PÃO, HAMBURGUER, BACON, SALSICHA, CALABRESA, OVO, CATUPIRY, PRESUNTO, MUSSARELA, ALFACE, TOMATE.',
                  price: 'R\$ 25,00',
                  imageUrl: 'assets/images/fotohamburguer.png',
                ),
                ProductCard(
                  title: 'X Bacon',
                  description:
                      'PÃO, HAMBURGUER, BACON, SALSICHA, OVO, CATUPIRY, PRESUNTO, MUSSARELA, ALFACE, TOMATE.',
                  price: 'R\$ 21,00',
                  imageUrl: 'assets/images/fotohamburguer.png',
                ),
                ProductCard(
                  title: 'X Moda da casa',
                  description:
                      'PÃO, HAMBURGUER, BACON, SALSICHA, CALABRESA, OVO, CATUPIRY, PRESUNTO, MUSSARELA, ALFACE, TOMATE.',
                  price: 'R\$ 23,00',
                  imageUrl: 'assets/images/fotohamburguer.png',
                ),
              ],
            ),
          ),
        ],
      ),
```
