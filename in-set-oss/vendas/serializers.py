from rest_framework import serializers
from .models import Venda, ItemVenda
from produtos.models import Produto


class ItemVendaSerializer(serializers.ModelSerializer):
    class Meta:
        model = ItemVenda
        fields = ['id', 'produto', 'quantidade', 'preco_unitario']


class ItemVendaCreateSerializer(serializers.Serializer):
    produto_id = serializers.IntegerField()
    quantidade = serializers.IntegerField(min_value=1)


class VendaSerializer(serializers.ModelSerializer):
    itens = ItemVendaSerializer(many=True, read_only=True)

    class Meta:
        model = Venda
        fields = ['id', 'data', 'valor_total', 'cliente', 'usuario', 'itens']
        read_only_fields = ['id', 'data', 'valor_total', 'usuario']


class CriarVendaSerializer(serializers.Serializer):
    cliente_id = serializers.IntegerField()
    itens      = ItemVendaCreateSerializer(many=True)

    def validate_itens(self, itens):
        if not itens:
            raise serializers.ValidationError('A venda deve ter pelo menos um item.')
        return itens

    def validate(self, data):
        for item in data['itens']:
            try:
                produto = Produto.objects.get(id=item['produto_id'])
            except Produto.DoesNotExist:
                raise serializers.ValidationError(f'Produto {item["produto_id"]} não encontrado.')
            if not produto.tem_estoque_suficiente(item['quantidade']):
                raise serializers.ValidationError(
                    f'Estoque insuficiente para o produto "{produto.nome}". '
                    f'Disponível: {produto.quantidade_estoque}, solicitado: {item["quantidade"]}.'
                )
        return data