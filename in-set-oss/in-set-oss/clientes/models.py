from django.db import models


class Cliente(models.Model):
    nome      = models.CharField(max_length=150)
    cpf       = models.CharField(max_length=11, unique=True)
    email     = models.EmailField(max_length=200)
    telefone  = models.CharField(max_length=20, blank=True, null=True)
    endereco  = models.TextField(blank=True, null=True)
    criado_em = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'clientes'
        verbose_name = 'Cliente'

    def __str__(self):
        return f'{self.nome} ({self.cpf})'