from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from django.db.models import Sum, Count
from django.db.models.functions import TruncMonth
from vendas.models import Venda
from vendas.serializers import VendaSerializer
from usuarios.permissions import IsAdmin


class RelatorioPeriodoView(APIView):
    permission_classes = [IsAuthenticated, IsAdmin]

    def get(self, request):
        data_inicio = request.query_params.get('inicio')
        data_fim    = request.query_params.get('fim')

        if not data_inicio or not data_fim:
            return Response(
                {'erro': True, 'mensagem': 'Informe os parâmetros inicio e fim (YYYY-MM-DD).'},
                status=400
            )

        vendas = Venda.objects.filter(data__date__gte=data_inicio, data__date__lte=data_fim)
        total  = vendas.aggregate(total=Sum('valor_total'))['total'] or 0

        return Response({
            'periodo': {'inicio': data_inicio, 'fim': data_fim},
            'total_vendas': vendas.count(),
            'valor_total': total,
            'vendas': VendaSerializer(vendas, many=True).data,
        })


class RelatorioClienteView(APIView):
    permission_classes = [IsAuthenticated, IsAdmin]

    def get(self, request, cliente_id):
        vendas = Venda.objects.filter(cliente_id=cliente_id).order_by('-data')
        total  = vendas.aggregate(total=Sum('valor_total'))['total'] or 0

        return Response({
            'cliente_id': cliente_id,
            'total_vendas': vendas.count(),
            'valor_total': total,
            'vendas': VendaSerializer(vendas, many=True).data,
        })


class RelatorioAnualView(APIView):
    permission_classes = [IsAuthenticated, IsAdmin]

    def get(self, request):
        ano = request.query_params.get('ano')

        vendas = Venda.objects.all()
        if ano:
            vendas = vendas.filter(data__year=ano)

        dados = (
            vendas
            .annotate(mes=TruncMonth('data'))
            .values('mes')
            .annotate(total=Sum('valor_total'), quantidade=Count('id'))
            .order_by('mes')
        )

        return Response([{
            'mes': item['mes'].strftime('%Y-%m'),
            'total': item['total'],
            'quantidade': item['quantidade'],
        } for item in dados])
