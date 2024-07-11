# Sistema de Cadastro de Contatos
Esses sistema foi feito para cadastrar contatos usando serviços externos para buscar endereços e geolocalização usando VIA CEP e a própria api do Google Maps.
A arquitetura desse projeto foi montado em cima da Hexagonal, mas possui algumas bases da Arquitetura Limpa. Foi usado também conceitos do SOLID e Design Patterns
Esse projeto está quase 100% de cobertura de testes, o fato de não estar 100% é por conta da falta de testes referente as funcionalidade do devise (TODO)

## Pré-requisitos

- Docker
- Docker Compose
- Conta Google Cloud (Para acessar apis do Google Maps)

## Uso do Docker

Este projeto está configurado para ser executado usando Docker e Docker Compose. Isso simplifica a configuração e garante que o ambiente de todos os desenvolvedores seja consistente.

### Instruções para Uso do Docker

1. **Clonar o repositório:**
   ```bash
   git clone https://seurepositorio.com/projeto.git
   cd projeto
   ```

2. **Configurar as variáveis de ambiente:**
Crie um arquivo .env na raiz do projeto e preencha-o com as variáveis necessárias conforme o exemplo .env.example.
  ```bash
  POSTGRES_DB=nome_do_db
  POSTGRES_USER=usuario
  POSTGRES_PASSWORD=senha
  RAILS_ENV=development
  RAILS_MASTER_KEY=chave_mestra_rails
  GMAIL_USERNAME=seu_usuario@gmail.com
  GMAIL_PASSWORD=sua_senha
  VIA_CEP_HOST=url_api_cep
  GOOGLE_MAPS_HOST=url_api_maps
  GOOGLE_MAPS_KEY=sua_chave_google_maps
  ```

3. **Construir e rodar o aplicativo usando Docker Compose:**
  ```bash
  docker-compose up --build
  ```
  Este comando constrói a imagem do aplicativo se necessário e inicia todos os serviços definidos no docker-compose.yml, incluindo o banco de dados e a aplicação Rails.

4. **Acessar o aplicativo:**
  - O aplicativo estará disponível em http://localhost:3000.

5. **Executar comandos dentro do container:**
  - Para executar comandos Rails ou Rake, você pode usar:
  ```bash
  docker-compose run contacts_api <comando>
  ```
  - Por exemplo, para criar o banco de dados:
  ```bash
  docker-compose run contacts_api rails db:create db:migrate
  ```
  - Para rodar os testes:
  ```bash
  docker-compose run contacts_api rspec
  ```

6. **Encerrar os serviços:**
  ```bash
  docker-compose down
  ```

## Documentação
Está disponível a documentação referente aos endopints criados utilizando esse link http://localhost:3000/api-docs

## Bibliotecas e Gems

Este projeto utiliza várias gems para facilitar o desenvolvimento e garantir funcionalidades robustas. Abaixo estão algumas das principais gems utilizadas e suas funções no projeto:

### Rails

- **Rails (`rails`)**: Framework web utilizado para construir toda a aplicação. Escolhido pela sua extensa comunidade e facilidades para desenvolvimento de aplicações web complexas.

### Banco de Dados

- **PostgreSQL (`pg`)**: Gem que permite a conexão com o banco de dados PostgreSQL, escolhido pela sua robustez e suporte a recursos avançados de bancos de dados.

### Autenticação

- **Devise Token Auth (`devise_token_auth`)**: Utilizada para adicionar autenticação baseada em tokens à aplicação. Essa gem facilita a implementação de registro, login e logout seguros em APIs Rails.

### Clientes HTTP

- **Faraday (`faraday`)**: Gem para realizar requisições HTTP. Usada para integrar com APIs externas como a do Google Maps e ViaCEP.

### Geolocalização

- **CPF CNPJ (`cpf_cnpj`)**: Gem para validar e gerar CPFs e CNPJs, usada para garantir que os CPFs dos contatos sejam válidos.

### Testes

- **RSpec (`rspec-rails`)**: Framework de teste para Rails, utilizado para escrever e executar testes unitários e de integração.
- **FactoryBot (`factory_bot_rails`)**: Utilizada para criar e gerenciar objetos de teste de forma fácil e eficiente.
- **Faker (`faker`)**: Gem que gera dados falsos para uso em testes e seed de banco de dados.
- **Database Cleaner (`database_cleaner-active_record`)**: Garante um estado limpo para os testes ao limpar o banco de dados entre os testes.

### Documentação da API

- **RSwag (`rswag`)**: Integra a geração de especificações OpenAPI/Swagger com aplicações Rails para ajudar na documentação e teste de APIs.

### Desenvolvimento e Debugging

- **Pry (`pry-byebug`)**: Combinação de `pry` e `byebug` para proporcionar uma interface interativa de debugging em Rails.
- **Letter Opener (`letter_opener`)**: Utilizada em desenvolvimento para abrir emails enviados em uma janela do navegador, facilitando a visualização durante o desenvolvimento.
