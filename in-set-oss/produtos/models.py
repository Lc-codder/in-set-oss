from django.db import models


class Produto(models.Model):
    nome               = models.CharField(max_length=150)
    descricao          = models.TextField(blank=True, null=True)
    preco              = models.DecimalField(max_digits=10, decimal_places=2)
    quantidade_estoque = models.IntegerField(default=0)
    estoque_minimo     = models.IntegerField(default=0)

    class Meta:
        db_table = 'produtos'
        verbose_name = 'Produto'

    def __str__(self):
        return f'{self.nome} (R$ {self.preco})'

    def tem_estoque_suficiente(self, quantidade):
        return self.quantidade_estoque >= quantidade

    def reduzir_estoque(self, quantidade):
        if not self.tem_estoque_suficiente(quantidade):
            raise ValueError(f'Estoque insuficiente para o produto {self.nome}.')
        self.quantidade_estoque -= quantidade
        self.save()