from django.shortcuts import render
from rest_framework import generics, status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from django.shortcuts import get_object_or_404
from .models import Venda, ItemVenda
from .serializers import VendaSerializer, CriarVendaSerializer
from clientes.models import Cliente
from produtos.models import Produto
from usuarios.permissions import IsAdminOrFuncionario


class VendaListView(generics.ListAPIView):
    queryset = Venda.objects.all().order_by('-data')
    serializer_class = VendaSerializer
    permission_classes = [IsAuthenticated, IsAdminOrFuncionario]


class VendaDetailView(generics.RetrieveAPIView):
    queryset = Venda.objects.all()
    serializer_class = VendaSerializer
    permission_classes = [IsAuthenticated, IsAdminOrFuncionario]


class CriarVendaView(APIView):
    permission_classes = [IsAuthenticated, IsAdminOrFuncionario]

    def post(self, request):
        serializer = CriarVendaSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        data = serializer.validated_data

        cliente = get_object_or_404(Cliente, id=data['cliente_id'])

        venda = Venda.objects.create(
            cliente=cliente,
            usuario=request.user,
            valor_total=0
        )

        for item_data in data['itens']:
            produto = Produto.objects.get(id=item_data['produto_id'])
            ItemVenda.objects.create(
                venda=venda,
                produto=produto,
                quantidade=item_data['quantidade'],
                preco_unitario=produto.preco
            )
            produto.reduzir_estoque(item_data['quantidade'])

        venda.calcular_total()

        return Response(VendaSerializer(venda).data, status=status.HTTP_201_CREATED)