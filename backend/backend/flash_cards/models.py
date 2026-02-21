import uuid

from django.db import models


class BaseModel(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4(), editable=False)
    created_at = models.DateField(auto_now_add=True, editable=False)

    class Meta:
        abstract = True


class User(BaseModel):
    name = models.CharField(null=False, blank=False, max_length=255)
    email = models.EmailField(blank=False, null=False)


class StackOfFlashCards(BaseModel):
    user = models.ForeignKey(
        User,
        related_name="stacks",
        on_delete=models.CASCADE, 
        null=False, 
        blank=False
    )

    title = models.CharField(blank=False, null=False, max_length=255)
    description = models.TextField()


class FlashCard(BaseModel):
    stack = models.ForeignKey(
        StackOfFlashCards,
        related_name="flash_cards",
        on_delete=models.CASCADE, 
        null=False, 
        blank=False        
    )

    front = models.TextField(blank=False, null=False)
    back = models.TextField(blank=False, null=False)

    level_of_knowledge = models.IntegerField(default=0, null=False, blank=False)