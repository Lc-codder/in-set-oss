import sqlite3

DB_NAME = "estoque.db"

# Banco de dados e tabela
def criar_banco():
    with sqlite3.connect(DB_NAME) as conn:
        cursor = conn.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS produtos (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                nome TEXT UNIQUE NOT NULL,
                quantidade INTEGER NOT NULL,
                preco REAL NOT NULL
            )
        """)
        conn.commit()

def buscar_produto_por_nome(nome):
    nome = nome.strip()
    with sqlite3.connect(DB_NAME) as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT id, nome, quantidade, preco FROM produtos WHERE nome = ?", (nome,))
        return cursor.fetchone()  

def buscar_produto_por_id(id_produto):
    with sqlite3.connect(DB_NAME) as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT id, nome, quantidade, preco FROM produtos WHERE id = ?", (id_produto,))
        return cursor.fetchone()

# funçao e CRUD (retornam true false)
def criar_produto(nome, quantidade, preco):
    nome = nome.strip()
    if not nome:
        print(" Erro: nome vazio.")
        return False
    if quantidade < 0 or preco < 0:
        print(" Erro: quantidade e preço devem ser >= 0.")
        return False

    try:
        with sqlite3.connect(DB_NAME) as conn:
            cursor = conn.cursor()
            cursor.execute(
                "INSERT INTO produtos (nome, quantidade, preco) VALUES (?, ?, ?)",
                (nome, quantidade, preco)
            )
            conn.commit()
        print(f" Produto '{nome}' adicionado com sucesso!")
        return True
    except sqlite3.IntegrityError:
        return False

def atualizar_produto(id_produto, quantidade, preco):
    if quantidade < 0 or preco < 0:
        print(" Erro: quantidade e preço devem ser >= 0.")
        return False
    with sqlite3.connect(DB_NAME) as conn:
        cursor = conn.cursor()
        cursor.execute(
            "UPDATE produtos SET quantidade = ?, preco = ? WHERE id = ?",
            (quantidade, preco, id_produto)
        )
        conn.commit()
        if cursor.rowcount == 0:
            return False
        return True

def somar_quantidade(id_produto, quantidade_a_adicionar):
    if quantidade_a_adicionar < 0:
        print(" Erro: quantidade a adicionar deve ser >= 0.")
        return False
    with sqlite3.connect(DB_NAME) as conn:
        cursor = conn.cursor()
        cursor.execute("UPDATE produtos SET quantidade = quantidade + ? WHERE id = ?", (quantidade_a_adicionar, id_produto))
        conn.commit()
        return cursor.rowcount > 0

def deletar_produto(id_produto):
    with sqlite3.connect(DB_NAME) as conn:
        cursor = conn.cursor()
        cursor.execute("DELETE FROM produtos WHERE id = ?", (id_produto,))
        conn.commit()
        return cursor.rowcount > 0

# Leitura / listagem
def listar_produtos():
    with sqlite3.connect(DB_NAME) as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT id, nome, quantidade, preco FROM produtos")
        produtos = cursor.fetchall()
    if produtos:
        print("\n Estoque Atual:")
        print("-"*50)
        for p in produtos:
            print(f"ID: {p[0]} | Nome: {p[1]} | Quantidade: {p[2]} | Preço: R${p[3]:.2f}")
    else:
        print(" Nenhum produto cadastrado.")

# Verificações de ação
def pode_realizar_acao(id_produto, quantidade_necessaria):
    """
    Verifica se existe produto e se há quantidade suficiente.
    Retorna: (True, mensagem) ou (False, mensagem)
    """
    if quantidade_necessaria < 0:
        return False, "Quantidade necessária inválida (negativa)."
    produto = buscar_produto_por_id(id_produto)
    if not produto:
        return False, "Produto com esse ID não existe."
    quantidade_atual = produto[2]
    if quantidade_atual >= quantidade_necessaria:
        return True, "Ação permitida: estoque suficiente."
    else:
        return False, f"Ação negada: estoque insuficiente (tem {quantidade_atual}, precisa {quantidade_necessaria})."

# Fluxos de interação 
def tentar_criar_ou_atualizar(nome, quantidade, preco):
    """
    Tenta criar; se já existir, pergunta ao usuário o que fazer:
      (1) atualizar (substituir quantidade e preço)
      (2) somar à quantidade existente
      (3) cancelar
    """
    nome = nome.strip()
    if not nome:
        print(" Nome vazio.")
        return

    criado = criar_produto(nome, quantidade, preco)
    if criado:
        return

    produto = buscar_produto_por_nome(nome)  
    
    id_existente, _, q_atual, p_atual = produto
    print(f" Produto '{nome}' já existe (ID {id_existente}) — Quantidade: {q_atual}, Preço: R${p_atual:.2f}")
    print("O que deseja fazer?")
    print("1 - Substituir quantidade e preço (atualizar)")
    print("2 - Somar à quantidade existente")
    print("3 - Cancelar")

    escolha = input("Escolha (1/2/3): ").strip()
    if escolha == "1":
        ok = atualizar_produto(id_existente, quantidade, preco)
        if ok:
            print(" Produto atualizado (substituído) com sucesso.")
        else:
            print(" Falha ao atualizar produto.")
    elif escolha == "2":
        try:
            adicionar = int(input("Quantidade a somar: "))
            if adicionar < 0:
                print(" Quantidade inválida.")
                return
        except ValueError:
            print(" Quantidade inválida.")
            return
        ok = somar_quantidade(id_existente, adicionar)
        if ok:
            print(" Quantidade somada com sucesso.")
        else:
            print(" Falha ao somar quantidade.")
    else:
        print(" Operação cancelada.")

# Menu interativo
def menu():
    criar_banco()
    while True:
        print("\n====== MENU ESTOQUE ======")
        print("1 - Adicionar Produto")
        print("2 - Listar Produtos")
        print("3 - Atualizar Produto (substituir quantidade/preço)")
        print("4 - Deletar Produto")
        print("5 - Verificar se posso realizar uma ação (ex: vender X unidades)")
        print("6 - Sair")
        opcao = input("Escolha uma opcao: ").strip()

        if opcao == "1":
            nome = input("Nome do produto: ")
            try:
                quantidade = int(input("Quantidade: "))
                preco = float(input("Preço: "))
                tentar_criar_ou_atualizar(nome, quantidade, preco)
            except ValueError:
                print(" Erro: quantidade deve ser inteiro e preço deve ser número real.")
        
        elif opcao == "2":
            listar_produtos()
        
        elif opcao == "3":
            try:
                id_produto = int(input("ID do produto: "))
                quantidade = int(input("Nova quantidade: "))
                preco = float(input("Novo preço: "))
                ok = atualizar_produto(id_produto, quantidade, preco)
                if ok:
                    print(" Produto atualizado com sucesso!")
                else:
                    print(" Erro: ID não encontrado ou valores inválidos.")
            except ValueError:
                print(" Erro: valores inválidos.")
        
        elif opcao == "4":
            try:
                id_produto = int(input("ID do produto: "))
                confirmar = input("Tem certeza que deseja deletar? (s/n): ").strip().lower()
                if confirmar == "s":
                    ok = deletar_produto(id_produto)
                    if ok:
                        print(" Produto deletado com sucesso!")
                    else:
                        print(" Erro: ID não encontrado.")
                else:
                    print(" Exclusão cancelada.")
            except ValueError:
                print(" Erro: o ID deve ser um número inteiro.")
        
        elif opcao == "5":
            try:
                id_produto = int(input("ID do produto: "))
                qtd = int(input("Quantidade necessária: "))
                ok, msg = pode_realizar_acao(id_produto, qtd)
                if ok:
                    print("✅", msg)
                    # Exemplo: perguntar se deseja consumir essa quantidade 
                    consumir = input("Deseja reduzir o estoque agora? (s/n): ").strip().lower()
                    if consumir == "s":
                        with sqlite3.connect(DB_NAME) as conn:
                            cursor = conn.cursor()
                            cursor.execute("UPDATE produtos SET quantidade = quantidade - ? WHERE id = ?", (qtd, id_produto))
                            conn.commit()
                        print(" Estoque reduzido.")
                else:
                    print("❌", msg)
            except ValueError:
                print(" Erro: valores inválidos.")
        
        elif opcao == "6":
            print("👋 Saindo do sistema...")
            break
        else:
            print(" Opção inválida! Tente novamente.")

if __name__ == "__main__":
    menu()
