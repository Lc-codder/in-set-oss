from django.contrib import admin
from django.urls import path, include
from drf_spectacular.views import SpectacularAPIView, SpectacularSwaggerView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/schema/', SpectacularAPIView.as_view(), name='schema'),
    path('api/docs/', SpectacularSwaggerView.as_view(url_name='schema'), name='docs'),
    path('auth/', include('usuarios.urls')),
    path('api/clientes/', include('clientes.urls')),
    path('api/produtos/', include('produtos.urls')),
    path('api/vendas/', include('vendas.urls')),
    path('api/relatorios/', include('relatorios.urls')),
    path('', include('usuarios.urls_frontend')),
]