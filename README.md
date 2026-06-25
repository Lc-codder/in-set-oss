# IN-SET-OSS

Sistema de gestão comercial do projeto social **Luta Mais** — jiu-jitsu, fé e propósito.

![Python](https://img.shields.io/badge/Python-3.10+-3776AB?logo=python&logoColor=white)
![Django](https://img.shields.io/badge/Django-092E20?logo=django&logoColor=white)
![DRF](https://img.shields.io/badge/Django%20REST%20Framework-API-A30000)
![JWT](https://img.shields.io/badge/Auth-JWT-black)
![License](https://img.shields.io/badge/uso-projeto%20social-blueviolet)

O Luta Mais é um projeto cristão batista que usa o jiu-jitsu para levar pessoas a conhecer Jesus. Para sustentar o projeto — kimonos, limpeza, estrutura — a equipe vende adesivos e chaveiros temáticos. O **IN-SET-OSS** é o sistema que gerencia essas vendas.

---

## Sumário

- [O que o sistema faz](#o-que-o-sistema-faz)
- [Como rodar](#como-rodar)
- [Telas disponíveis](#telas-disponíveis)
- [A API e a documentação Swagger](#a-api-e-a-documentação-swagger)
- [Perfis de acesso](#perfis-de-acesso)
- [Stack](#stack)
- [Estrutura do projeto](#estrutura-do-projeto)

---

## O que o sistema faz

- Login com controle de acesso por perfil (**ADMIN** e **FUNCIONÁRIO**)
- Cadastro e listagem de clientes, com validação de CPF e e-mail
- Cadastro e listagem de produtos, com controle de estoque
- Registro de vendas com cálculo automático do total
- Bloqueio automático quando o estoque é insuficiente
- Atualização de estoque após cada venda
- Relatórios de vendas por período e por cliente
- Gráfico de desempenho anual no dashboard

---

## Como rodar

### Pré-requisitos

- Python 3.10 ou superior
- Git

### Passo a passo

```bash
# 1. Clone o repositório
git clone https://github.com/Lc-codder/in-set-oss.git
cd in-set-oss

# 2. Crie e ative o ambiente virtual
python -m venv venv

# Windows:
venv\Scripts\activate
# Linux/Mac:
source venv/bin/activate

# 3. Instale as dependências
pip install -r requirements.txt

# 4. Crie o banco de dados
python manage.py migrate

# 5. Crie o usuário administrador
python manage.py createsuperuser

# 6. Rode o servidor
python manage.py runserver
```

Acesse em: **http://127.0.0.1:8000/login/**

---

## Telas disponíveis

| URL | Tela |
|---|---|
| `/login/` | Login |
| `/dashboard/` | Painel com totais e gráfico de vendas |
| `/clientes/` | Listagem de clientes |
| `/clientes/novo/` | Cadastro de cliente |
| `/produtos/` | Listagem de produtos |
| `/produtos/novo/` | Cadastro de produto |
| `/vendas/` | Listagem de vendas |
| `/vendas/criar/` | Registrar nova venda |
| `/relatorios/` | Relatórios e gráficos |
| `/api/docs/` | Documentação interativa da API (Swagger) |

---

## A API e a documentação Swagger

Além das telas web, o IN-SET-OSS expõe uma **API REST completa** (em `/api/...`), pensada para ser consumida por outros sistemas — um app mobile, uma integração externa, ou até testada manualmente via Swagger ou Postman.

### Como abrir a documentação da API

1. Com o servidor rodando (`python manage.py runserver`), acesse:

   👉 **http://127.0.0.1:8000/api/docs/**

2. Essa página é gerada automaticamente pelo `drf-spectacular` e mostra **todos os endpoints da API** organizados por app (usuários, clientes, produtos, vendas, relatórios), com:
   - os parâmetros que cada endpoint aceita;
   - o formato de resposta esperado (JSON);
   - um botão **"Try it out"** para testar a chamada direto pelo navegador, sem precisar de Postman.

3. Se preferir o JSON puro do schema (útil para importar em ferramentas como Postman/Insomnia), ele fica disponível em:

   👉 **http://127.0.0.1:8000/api/schema/**

### Autenticando na API (JWT)

A maioria dos endpoints exige autenticação. O fluxo é:

```bash
# 1. Faça login para obter o token
POST /api/login/
Content-Type: application/json

{
  "username": "seu_usuario",
  "password": "sua_senha"
}
```

A resposta traz o `access` token e o `refresh` token:

```json
{
  "access": "eyJ0eXAiOiJKV1QiLCJhbGciOi...",
  "refresh": "eyJ0eXAiOiJKV1QiLCJhbGciOi...",
  "usuario": { "id": 1, "username": "seu_usuario", "perfil": "ADMIN" }
}
```

```bash
# 2. Use o access token em toda chamada seguinte
GET /api/clientes/
Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOi...
```

> O **access token** expira em 8 horas. Quando expirar, use o **refresh token** em `POST /api/token/refresh/` para gerar um novo, sem precisar logar de novo.

**Testando direto pelo Swagger:** na página `/api/docs/`, clique no botão **"Authorize"** (cadeado no topo) e cole o `access` token — assim todos os "Try it out" da página já vão autenticados automaticamente.

### Principais grupos de endpoints

| Recurso | Prefixo | O que faz |
|---|---|---|
| Usuários | `/api/login/`, `/api/usuarios/` | Login, refresh de token, gestão de usuários |
| Clientes | `/api/clientes/` | CRUD de clientes |
| Produtos | `/api/produtos/` | CRUD de produtos e estoque |
| Vendas | `/api/vendas/` | Listagem, detalhe e criação de vendas |
| Relatórios | `/api/relatorios/` | Vendas por período, por cliente e totais anuais |

---

## Perfis de acesso

| Perfil | Permissões |
|---|---|
| **ADMIN** | Acesso completo — clientes, produtos, vendas, relatórios e gestão de usuários |
| **FUNCIONÁRIO** | Visualizar clientes/produtos e registrar vendas |

---

## Stack

| Componente | Tecnologia |
|---|---|
| Backend | Python + Django + Django REST Framework |
| Autenticação | JWT (simplejwt) + Sessão Django |
| Banco de dados | SQLite |
| Frontend | Django Templates + Bootstrap 5 + Chart.js |
| Documentação API | drf-spectacular (Swagger) |

---

## Estrutura do projeto

```
in-set-oss/
├── core/           # Configurações do Django
├── usuarios/       # Autenticação e controle de acesso
├── clientes/       # CRUD de clientes
├── produtos/       # CRUD de produtos e estoque
├── vendas/         # Registro de vendas
├── relatorios/     # Relatórios e gráficos
├── templates/      # Interface web
├── manage.py
└── requirements.txt
```

---

*Para a glória de Deus — e pra ajudar o projeto a ter kimono bom pra todo mundo.* 🥋
