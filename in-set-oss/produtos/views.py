from django.shortcuts import render
from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from .models import Produto
from .serializers import ProdutoSerializer
from usuarios.permissions import IsAdmin, IsAdminOrFuncionario


class ProdutoListCreateView(generics.ListCreateAPIView):
    queryset = Produto.objects.all().order_by('nome')
    serializer_class = ProdutoSerializer

    def get_permissions(self):
        if self.request.method == 'POST':
            return [IsAuthenticated(), IsAdmin()]
        return [IsAuthenticated(), IsAdminOrFuncionario()]


class ProdutoDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Produto.objects.all()
    serializer_class = ProdutoSerializer
    permission_classes = [IsAuthenticated, IsAdmin]