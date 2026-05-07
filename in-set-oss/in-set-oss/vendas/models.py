from django.db import models
from clientes.models import Cliente
from produtos.models import Produto
from usuarios.models import Usuario


class Venda(models.Model):
    data        = models.DateTimeField(auto_now_add=True)
    valor_total = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    cliente     = models.ForeignKey(Cliente, on_delete=models.PROTECT)
    usuario     = models.ForeignKey(Usuario, on_delete=models.PROTECT)

    class Meta:
        db_table = 'vendas'
        verbose_name = 'Venda'

    def __str__(self):
        return f'Venda #{self.id} — {self.cliente.nome}'

    def calcular_total(self):
        total = sum(item.subtotal() for item in self.itens.all())
        self.valor_total = total
        self.save()


class ItemVenda(models.Model):
    venda          = models.ForeignKey(Venda, on_delete=models.CASCADE, related_name='itens')
    produto        = models.ForeignKey(Produto, on_delete=models.PROTECT)
    quantidade     = models.IntegerField()
    preco_unitario = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        db_table = 'itens_venda'
        verbose_name = 'Item de Venda'

    def subtotal(self):
        return self.quantidade * self.preco_unitario