from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout


def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user:
            login(request, user)
            return redirect('/dashboard/')
        else:
            return render(request, 'login.html', {'erro': 'Usuário ou senha incorretos.'})
    return render(request, 'login.html')


def logout_view(request):
    logout(request)
    return redirect('/login/')


def dashboard_view(request):
    if not request.user.is_authenticated:
        return redirect('/login/')
    return render(request, 'dashboard.html')


def clientes_lista(request):
    if not request.user.is_authenticated:
        return redirect('/login/')
    return render(request, 'clientes/lista.html')


def cliente_form(request, cliente_id=None):
    if not request.user.is_authenticated:
        return redirect('/login/')
    return render(request, 'clientes/form.html', {
        'titulo': 'Editar Cliente' if cliente_id else 'Novo Cliente',
        'cliente_id': cliente_id or ''
    })


def produtos_lista(request):
    if not request.user.is_authenticated:
        return redirect('/login/')
    return render(request, 'produtos/lista.html')


def produto_form(request, produto_id=None):
    if not request.user.is_authenticated:
        return redirect('/login/')
    return render(request, 'produtos/form.html', {
        'titulo': 'Editar Produto' if produto_id else 'Novo Produto',
        'produto_id': produto_id or ''
    })


def vendas_lista(request):
    if not request.user.is_authenticated:
        return redirect('/login/')
    return render(request, 'vendas/lista.html')


def venda_criar(request):
    if not request.user.is_authenticated:
        return redirect('/login/')
    return render(request, 'vendas/criar.html')


def relatorios_view(request):
    if not request.user.is_authenticated:
        return redirect('/login/')
    return render(request, 'relatorios/index.html')