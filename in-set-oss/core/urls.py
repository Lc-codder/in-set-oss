from django.contrib import admin
from django.urls import path, include
from drf_spectacular.views import SpectacularAPIView, SpectacularSwaggerView
from rest_framework_simplejwt.views import TokenRefreshView

urlpatterns = [
    path('admin/', admin.site.urls),

    # Documentação
    path('api/schema/', SpectacularAPIView.as_view(), name='schema'),
    path('api/docs/', SpectacularSwaggerView.as_view(url_name='schema'), name='docs'),
    path('api/', include('usuarios.urls')),
    path('api/clientes/', include('clientes.urls')),
    path('api/produtos/', include('produtos.urls')),
    path('api/vendas/', include('vendas.urls')),
    path('api/relatorios/', include('relatorios.urls')),
    path('', include('usuarios.urls_frontend')),
]