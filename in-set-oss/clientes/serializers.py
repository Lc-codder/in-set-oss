import re
from rest_framework import serializers
from .models import Cliente


class ClienteSerializer(serializers.ModelSerializer):
    class Meta:
        model = Cliente
        fields = '__all__'
        read_only_fields = ['id', 'criado_em']

    def validate_cpf(self, value):
        cpf = re.sub(r'\D', '', value)
        if len(cpf) != 11:
            raise serializers.ValidationError('CPF deve ter 11 dígitos.')
        if cpf == cpf[0] * 11:
            raise serializers.ValidationError('CPF inválido.')
        return cpf

    def validate_email(self, value):
        if '@' not in value:
            raise serializers.ValidationError('E-mail inválido.')
        return value