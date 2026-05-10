from django.urls import path
from . import views_frontend

urlpatterns = [
    path('login/', views_frontend.login_view, name='login'),
    path('logout/', views_frontend.logout_view, name='logout'),
    path('dashboard/', views_frontend.dashboard_view, name='dashboard'),
    path('clientes/', views_frontend.clientes_lista, name='clientes_lista'),
    path('clientes/novo/', views_frontend.cliente_form, name='cliente_novo'),
    path('clientes/<int:cliente_id>/editar/', views_frontend.cliente_form, name='cliente_editar'),
    path('produtos/', views_frontend.produtos_lista, name='produtos_lista'),
    path('produtos/novo/', views_frontend.produto_form, name='produto_novo'),
    path('produtos/<int:produto_id>/editar/', views_frontend.produto_form, name='produto_editar'),
    path('vendas/', views_frontend.vendas_lista, name='vendas_lista'),
    path('vendas/criar/', views_frontend.venda_criar, name='venda_criar'),
    path('relatorios/', views_frontend.relatorios_view, name='relatorios'),
]