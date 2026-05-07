from rest_framework import serializers
from django.contrib.auth import authenticate
from .models import Usuario


class UsuarioSerializer(serializers.ModelSerializer):
    class Meta:
        model = Usuario
        fields = ['id', 'username', 'perfil', 'ativo', 'criado_em']
        read_only_fields = ['id', 'criado_em']


class CriarUsuarioSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True, min_length=6)

    class Meta:
        model = Usuario
        fields = ['username', 'password', 'perfil']

    def create(self, validated_data):
        return Usuario.objects.create_user(**validated_data)


class LoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField(write_only=True)

    def validate(self, data):
        user = authenticate(**data)
        if not user:
            raise serializers.ValidationError('Credenciais inválidas.')
        if not user.ativo:
            raise serializers.ValidationError('Usuário inativo.')
        return user