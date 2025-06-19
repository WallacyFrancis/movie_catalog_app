# 🎬 Movie Catalog App

Um aplicativo móvel moderno desenvolvido em Flutter para explorar e gerenciar um catálogo de filmes populares, integrado com a API do The Movie Database (TMDB).

## 📱 Funcionalidades

### ✨ Principais Recursos
- **Catálogo de Filmes**: Visualize filmes populares em um layout de grade responsivo
- **Sistema de Favoritos**: Adicione e gerencie seus filmes favoritos
- **Detalhes Completos**: Acesse informações detalhadas de cada filme
- **Interface Moderna**: Design dark theme com navegação intuitiva
- **Cache de Imagens**: Carregamento otimizado com cache automático
- **Navegação Fluida**: Sistema de rotas avançado com GoRouter

### 🎯 Telas Disponíveis
- **Home**: Lista de filmes populares em grid
- **Favoritos**: Coleção pessoal de filmes salvos
- **Detalhes**: Informações completas do filme selecionado

## 🛠️ Tecnologias Utilizadas

### Core Framework
- **Flutter 3.8+**: Framework de desenvolvimento multiplataforma
- **Dart**: Linguagem de programação

### Gerenciamento de Estado
- **Provider**: Gerenciamento de estado reativo para favoritos

### Navegação
- **GoRouter**: Sistema de roteamento declarativo e type-safe

### Comunicação com API
- **HTTP**: Cliente HTTP para requisições à API TMDB
- **flutter_dotenv**: Gerenciamento seguro de variáveis de ambiente

### UI/UX
- **Cached Network Image**: Carregamento e cache otimizado de imagens
- **Material Design**: Componentes de interface modernos
- **CustomScrollView**: Efeitos de rolagem avançados

## 📋 Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- **Flutter SDK** (versão 3.8.0 ou superior)
- **Dart SDK** (incluído com Flutter)
- **Android Studio** ou **VS Code** com extensões Flutter
- **Git** para controle de versão

## 🚀 Instalação e Configuração

### 1. Clone o Repositório
```bash
git clone https://github.com/seu-usuario/movie_catalog_app.git
cd movie_catalog_app
```

### 2. Instale as Dependências
```bash
flutter pub get
```

### 3. Configure a API Key do TMDB

1. Acesse [The Movie Database](https://www.themoviedb.org/) e crie uma conta
2. Vá para as configurações da API e gere uma chave de API
3. Crie um arquivo `.env` na raiz do projeto:
```env
TMDB_API_KEY=sua_chave_api_aqui
```

### 4. Execute o Projeto

#### Para Desenvolvimento
```bash
flutter run
```

#### Para Build de Produção
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 📁 Estrutura do Projeto

```
lib/
├── api/
│   └── tmdb_service.dart          # Serviço de comunicação com API TMDB
├── models/
│   └── movie.dart                 # Modelo de dados do filme
├── providers/
│   └── favorites_provider.dart    # Gerenciamento de estado dos favoritos
├── screens/
│   ├── home_screen.dart           # Tela principal com lista de filmes
│   ├── favorites_screen.dart      # Tela de favoritos
│   └── details_screen.dart        # Tela de detalhes do filme
├── widgets/
│   ├── movie_card.dart            # Widget do card de filme
│   └── scaffold_with_nav_bar.dart # Scaffold com navegação inferior
└── main.dart                      # Ponto de entrada da aplicação
```

## 🔧 Configurações Adicionais

### Variáveis de Ambiente
O projeto utiliza um arquivo `.env` para configurações sensíveis:
- `TMDB_API_KEY`: Chave de API do The Movie Database

### Análise de Código
O projeto inclui configurações de linting para manter a qualidade do código:
```bash
flutter analyze
```

## 📱 Compatibilidade

- **Android**: API Level 21+ (Android 5.0+)
- **iOS**: iOS 11.0+
- **Web**: Navegadores modernos com suporte a ES6

## 🤝 Contribuindo

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 🙏 Agradecimentos

- [The Movie Database (TMDB)](https://www.themoviedb.org/) pela API gratuita
- [Flutter Team](https://flutter.dev/) pelo framework incrível
- Comunidade Flutter por todas as bibliotecas e recursos

## 📞 Suporte

Se você encontrar algum problema ou tiver dúvidas, por favor:

1. Verifique se seguiu todos os passos de instalação
2. Certifique-se de que a API key está configurada corretamente
3. Abra uma issue no repositório com detalhes do problema

---

**Desenvolvido com ❤️ usando Flutter** 