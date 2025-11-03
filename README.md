# Pokémon Search App (Swift)

## Descrição

Aplicativo simples desenvolvido em **Swift** que permite ao usuário buscar informações sobre um Pokémon utilizando a **PokeAPI**. O app exibe dados como:

- **Nome**
- **ID (Número)**
- **Altura**
- **Peso**
- **Tipos**
- **Imagem do Pokémon**

O app inclui tratamento de erros, indicador de carregamento e uma interface simples construída com **UIKit**.

## Funcionalidades

- **Busca por nome ou ID**: Digite o nome ou ID do Pokémon (ex: "pikachu" ou "25").
- **Exibição de informações**: Exibe o nome, ID, altura, peso, tipos e imagem do Pokémon.
- **Indicador de carregamento**: Mostra um indicador enquanto a requisição à API está em andamento.
- **Tratamento de erros**: Exibe mensagens amigáveis caso o Pokémon não seja encontrado ou ocorra um erro.

## Tecnologias Utilizadas

- **Swift**: Linguagem de programação.
- **UIKit**: Framework para a interface de usuário.
- **URLSession**: Para requisições HTTP à PokeAPI.
- **JSONSerialization**: Para processamento de dados JSON.

## Estrutura do Projeto

1. **`Pokemon.swift`**: Modelo de dados representando um Pokémon.
2. **`PokemonService.swift`**: Serviço para fazer as requisições à PokeAPI e mapear os dados.
3. **`ViewController.swift`**: Controlador da interface do usuário, responsável pela interação com o usuário e exibição dos dados.

## Como Usar

1. Clone este repositório para o seu computador.
2. Abra o projeto no Xcode.
3. Execute o aplicativo no simulador ou em um dispositivo real.
4. Digite o nome ou ID de um Pokémon (ex: "pikachu" ou "25") e clique em "Buscar Pokémon".
5. Veja as informações do Pokémon sendo exibidas na tela.


