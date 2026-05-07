from django.urls import path
from .views import RelatorioPeriodoView, RelatorioClienteView, RelatorioAnualView

urlpatterns = [
    path('periodo/', RelatorioPeriodoView.as_view(), name='relatorio_periodo'),
    path('cliente/<int:cliente_id>/', RelatorioClienteView.as_view(), name='relatorio_cliente'),
    path('anual/', RelatorioAnualView.as_view(), name='relatorio_anual'),
]