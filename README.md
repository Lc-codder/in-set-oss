# in-set-oss

> Sistema de gestão comercial do projeto social **Luta Mais** — jiujitsu, fé e propósito.

O Luta Mais é um projeto cristão batista que usa o jiujitsu para levar pessoas a conhecer a Jesus. Para sustentar o projeto — kimonos, limpeza, estrutura — a equipe vende adesivos e chaveiros temáticos. O **in-set-oss** é o sistema que gerencia essas vendas.

---

## O que o sistema faz

- Login com controle de acesso por perfil (ADMIN e FUNCIONÁRIO)
- Cadastro e listagem de clientes com validação de CPF e e-mail
- Cadastro e listagem de produtos com controle de estoque
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
|-----|------|
| `/login/` | Login |
| `/dashboard/` | Painel com totais e gráfico de vendas |
| `/clientes/` | Listagem de clientes |
| `/clientes/novo/` | Cadastro de cliente |
| `/produtos/` | Listagem de produtos |
| `/produtos/novo/` | Cadastro de produto |
| `/vendas/` | Listagem de vendas |
| `/vendas/criar/` | Registrar nova venda |
| `/relatorios/` | Relatórios e gráficos |
| `/api/docs/` | Documentação da API (Swagger) |

---

## Perfis de acesso

| Perfil | Permissões |
|--------|-----------|
| `ADMIN` | Acesso completo — clientes, produtos, vendas, relatórios |

---

## Stack

| Componente | Tecnologia |
|-----------|-----------|
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
*Para a glória de Deus — e pra ajudar o projeto a ter kimono bom pra todo mundo.*
