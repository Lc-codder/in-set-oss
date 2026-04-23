# in-set-oss

> Sistema de gestão comercial do projeto social **Luta Mais** — jiujitsu, fé e propósito.

---

## O que é isso aqui?

O Luta Mais não é só uma escolinha de jiujitsu. É um projeto cristão batista que acredita que o tatame pode ser um lugar de encontro com Jesus. A ideia é simples: acolher pessoas que talvez nunca entrassem numa igreja, e mostrar que tem algo maior acontecendo ali — no meio do suor, da disciplina e da comunidade.

Para sustentar tudo isso — comprar kimonos, manter o espaço limpo, crescer de forma estruturada — o projeto vende adesivos e chaveiros. Cada adesivo colado num carro, num notebook ou numa garrafa é a mensagem do projeto chegando em algum lugar onde ela não chegaria de outra forma.

O **in-set-oss** é o sistema que cuida dessa parte. Cadastro de clientes, controle de estoque, registro de vendas, relatórios. Nada de planilha perdida ou anotação no papel. O projeto merece estrutura.

---

## O que o sistema faz

- Cadastro completo de clientes (com validação de CPF e e-mail)
- Gestão de produtos e controle de estoque em tempo real
- Registro de vendas com cálculo automático do total
- Bloqueio automático quando o estoque não é suficiente
- Relatórios de vendas por período e por cliente
- Gráfico de desempenho anual
- Autenticação com JWT e controle de acesso por perfil (admin e funcionário)

---

## Stack

| Camada | Tecnologia |
|--------|-----------|
| Backend | Python 3.12 + Django 5 + Django REST Framework |
| Autenticação | djangorestframework-simplejwt |
| Banco de dados | PostgreSQL 16 |
| Senhas | BCrypt |
| Frontend | Django Templates + Bootstrap 5 + Chart.js |
| Documentação da API | drf-spectacular (Swagger) |

---

## Como rodar localmente

**Pré-requisitos:** Python 3.12+, PostgreSQL, Git

```bash
# Clone o repositório
git clone https://github.com/[usuario]/in-set-oss.git
cd in-set-oss

# Crie e ative o ambiente virtual
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Instale as dependências
pip install -r requirements.txt

# Configure as variáveis de ambiente
cp .env.example .env
# Edite o .env com suas credenciais do banco

# Crie o banco de dados
psql -U postgres -f scripts/create_db.sql

# Rode as migrations
python manage.py migrate

# Crie um usuário admin
python manage.py createsuperuser

# Inicie o servidor
python manage.py runserver
```

Acesse em `http://localhost:8000`

A documentação da API fica em `http://localhost:8000/api/docs`

---

## Estrutura do projeto

```
in-set-oss/
├── core/               # Configurações principais do Django
├── usuarios/           # Autenticação e controle de acesso
├── clientes/           # Gestão de clientes
├── produtos/           # Gestão de produtos e estoque
├── vendas/             # Registro e histórico de vendas
├── relatorios/         # Relatórios e gráficos
├── templates/          # Frontend (Django Templates)
├── scripts/            # Script SQL e utilitários
└── docs/               # Diagramas e documentação técnica
```

---

## Variáveis de ambiente

Crie um arquivo `.env` na raiz com:

```env
SECRET_KEY=sua_chave_secreta_aqui
DEBUG=True
DB_NAME=insetoss
DB_USER=postgres
DB_PASSWORD=sua_senha
DB_HOST=localhost
DB_PORT=5432
JWT_EXPIRATION_HOURS=8
```

---

## Perfis de acesso

| Perfil | O que pode fazer |
|--------|-----------------|
| `ADMIN` | Tudo — clientes, produtos, vendas, relatórios, usuários |
| `FUNCIONARIO` | Registrar vendas, consultar clientes e produtos |

---

## Entregas do projeto

- **Entrega 1 (03/04)** — Modelagem e arquitetura ✅
- **Entrega 2 (08/05)** — Backend e API
- **Entrega 3 (26/06)** — Sistema completo com JWT, e-mail e documentação final

---

## Contexto

Trabalho acadêmico da disciplina **Construção de Código Orientado a Objetos (CCO)**.
O contexto real escolhido foi o projeto social Luta Mais — porque faz sentido construir algo que tem propósito de verdade.

---

*Para a glória de Deus — e pra ajudar o projeto a ter kimono bom pra todo mundo.*
