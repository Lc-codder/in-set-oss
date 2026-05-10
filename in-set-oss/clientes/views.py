from django.shortcuts import render
from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from .models import Cliente
from .serializers import ClienteSerializer
from usuarios.permissions import IsAdmin, IsAdminOrFuncionario


class ClienteListCreateView(generics.ListCreateAPIView):
    queryset = Cliente.objects.all().order_by('nome')
    serializer_class = ClienteSerializer

    def get_permissions(self):
        if self.request.method == 'POST':
            return [IsAuthenticated(), IsAdmin()]
        return [IsAuthenticated(), IsAdminOrFuncionario()]


class ClienteDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Cliente.objects.all()
    serializer_class = ClienteSerializer
    permission_classes = [IsAuthenticated, IsAdmin]

    def destroy(self, request, *args, **kwargs):
        cliente = self.get_object()
        if cliente.venda_set.exists():
            return Response(
                {'erro': True, 'mensagem': 'Cliente possui vendas registradas e não pode ser removido.'},
                status=status.HTTP_400_BAD_REQUEST
            )
        return super().destroy(request, *args, **kwargs)