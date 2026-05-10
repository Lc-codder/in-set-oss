from django.urls import path
from .views import VendaListView, VendaDetailView, CriarVendaView

urlpatterns = [
    path('', VendaListView.as_view(), name='vendas'),
    path('<int:pk>/', VendaDetailView.as_view(), name='venda_detail'),
    path('criar/', CriarVendaView.as_view(), name='criar_venda'),
]