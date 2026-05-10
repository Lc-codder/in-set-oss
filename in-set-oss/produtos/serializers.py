from rest_framework import serializers
from .models import Produto


class ProdutoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Produto
        fields = '__all__'
        read_only_fields = ['id']

    def validate_preco(self, value):
        if value < 0:
            raise serializers.ValidationError('Preço não pode ser negativo.')
        return value

    def validate_quantidade_estoque(self, value):
        if value < 0:
            raise serializers.ValidationError('Estoque não pode ser negativo.')
        return value