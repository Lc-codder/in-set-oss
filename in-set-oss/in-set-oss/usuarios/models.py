from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin
from django.db import models


class UsuarioManager(BaseUserManager):
    def create_user(self, username, password=None, **extra_fields):
        if not username:
            raise ValueError('Username é obrigatório')
        user = self.model(username=username, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, username, password=None, **extra_fields):
        extra_fields.setdefault('perfil', 'ADMIN')
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        return self.create_user(username, password, **extra_fields)


class Usuario(AbstractBaseUser, PermissionsMixin):
    PERFIL_CHOICES = [
        ('ADMIN', 'Administrador'),
        ('FUNCIONARIO', 'Funcionário'),
    ]

    username  = models.CharField(max_length=100, unique=True)
    perfil    = models.CharField(max_length=20, choices=PERFIL_CHOICES, default='FUNCIONARIO')
    ativo     = models.BooleanField(default=True)
    criado_em = models.DateTimeField(auto_now_add=True)
    is_staff  = models.BooleanField(default=False)

    objects = UsuarioManager()

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = []

    class Meta:
        db_table = 'usuarios'
        verbose_name = 'Usuário'

    def __str__(self):
        return f'{self.username} ({self.perfil})'