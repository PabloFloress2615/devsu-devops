from django.urls import reverse
from rest_framework.test import APITestCase
import json
from .models import User


class TestUserView(APITestCase):
    def setUp(self):
        self.user = User.objects.create(name="Test1", dni="09876543210")
        self.list_url = reverse("api:users-list")
        self.detail_url = reverse("api:users-detail", args=[self.user.id])
        self.data = {"name": "Test2", "dni": "09876543211"}

    def test_post(self):
        response = self.client.post(self.list_url, self.data, format="json")
        self.assertEqual(response.status_code, 201)
        self.assertEqual(
            json.loads(response.content),
            {"id": 2, "name": "Test2", "dni": "09876543211"},
        )

    def test_get_list(self):
        response = self.client.get(self.list_url)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(len(json.loads(response.content)), 1)

    def test_get(self):
        response = self.client.get(self.detail_url)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(
            json.loads(response.content),
            {"id": 1, "name": "Test1", "dni": "09876543210"},
        )
