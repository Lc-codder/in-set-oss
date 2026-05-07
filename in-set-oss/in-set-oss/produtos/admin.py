from django.contrib import admin
from .models import Produto

@admin.register(Produto)
class ProdutoAdmin(admin.ModelAdmin):
    list_display = ['nome', 'preco', 'quantidade_estoque', 'estoque_minimo']
    search_fields = ['nome']