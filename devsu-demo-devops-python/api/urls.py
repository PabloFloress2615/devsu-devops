from rest_framework import routers
from .views import UserViewSet


class OptionalSlashRouter(routers.DefaultRouter):
    def __init__(self):
        super().__init__()
        self.trailing_slash = "/?"  # <- barra opcional


router = OptionalSlashRouter()
router.register("users", UserViewSet, basename="users")

app_name = "api"
urlpatterns = router.urls
