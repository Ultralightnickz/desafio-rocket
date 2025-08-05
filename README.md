# Desafio: Aplicação Flask com PostgreSQL usando Docker e Docker Compose

Este projeto é uma solução para o desafio proposto, que consiste em:

- Criar uma aplicação web com qualquer linguagem (utilizado Flask com Python)
- Utilizar PostgreSQL como banco de dados
- Gerenciar variáveis de ambiente de forma segura
- Utilizar múltiplos estágios com Docker, com imagens Alpine
- Evitar uso do usuário root para conexão ao banco

---

## Tecnologias Utilizadas

- Python 3.9
- Flask
- PostgreSQL 15
- Docker
- Docker Compose
- Imagens Alpine (multi-stage build)
- Variáveis de ambiente via `.env`

---

## Estrutura do Projeto

```
├── app/
│ ├── main.py
│ └── requirements.txt
├── .dockerignore
├── .gitignore
├── .env
├── Dockerfile
├── docker-compose.yaml
└── README.md
```

---

## Arquivos de Ignore

- `.gitignore`: evita versionar arquivos desnecessários como `__pycache__/`, `.env`, e dependências locais.
- `.dockerignore`: evita copiar arquivos desnecessários para o build da imagem Docker, melhorando performance e segurança.

---

## Como Executar

> Certifique-se de ter o Docker e o Docker Compose instalados.

### 1. Clonar o repositório

```bash
git clone https://github.com/Ultralightnickz/desafio-rocket
cd desafio-rocket
```

### 2. Configurar as variáveis de ambiente

Crie um arquivo `.env` na raiz do projeto com o seguinte conteúdo:

```env
DB_HOST=db
DB_NAME=fake
DB_USER=fake
DB_PASSWORD=fake
```

### 3. Subir os containers

```bash
docker-compose up --build -d
```

Isso irá:

- Construir a imagem da aplicação Flask com Alpine
- Subir o banco de dados PostgreSQL com as credenciais definidas
- Rodar a aplicação na porta 5000

### 4. Acessar a aplicação

Abra o navegador e acesse:

```
http://localhost:5000
```

Você verá uma mensagem indicando se a aplicação conseguiu se conectar ao banco com sucesso.

---

## Docker

### Dockerfile (resumo)

- Multi-stage build com Alpine em ambos os estágios
- No estágio de build: instala dependências de sistema para compilar o `psycopg2`
- No estágio final: usa apenas as bibliotecas necessárias para execução

### Docker Compose

- Define dois serviços:
  - `web`: a aplicação Flask
  - `db`: PostgreSQL
- Ambos os serviços estão na mesma rede (`app_network`)
- Volume persistente para os dados do PostgreSQL

---

## Endpoints

#### GET `/`

- Testa a conexão com o banco de dados PostgreSQL
- Retorna uma mensagem de sucesso ou erro

---

## Testes

1. Acesse `http://localhost:5000` após subir os containers
2. A aplicação deve exibir:

```
Conectado ao banco com sucesso!
```

3. Se o banco estiver fora do ar ou com dados incorretos, a aplicação mostrará uma mensagem de erro tratada.

---

## Observações

- A aplicação foi desenvolvida com foco em boas práticas de containerização e isolamento de ambientes.
- O servidor Flask está em modo desenvolvimento e **não deve ser usado em produção**.