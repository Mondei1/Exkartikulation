import uuid

from django.core.management.base import BaseCommand

from backend.flash_cards.models import FlashCard, StackOfFlashCards, User


USER_ID = uuid.UUID("11111111-1111-1111-1111-111111111111")
STACK_ID = uuid.UUID("22222222-2222-2222-2222-222222222222")
FLASHCARD_ID = uuid.UUID("33333333-3333-3333-3333-333333333333")


class Command(BaseCommand):
    help = "Seed deterministic sample data for API requests."

    def handle(self, *args, **options):
        user, _ = User.objects.update_or_create(
            id=USER_ID,
            defaults={
                "name": "Max Mustermann",
                "email": "max@example.com",
            },
        )

        stack, _ = StackOfFlashCards.objects.update_or_create(
            id=STACK_ID,
            defaults={
                "user": user,
                "title": "Python Basics",
                "description": "Basiswissen zu Python.",
            },
        )

        FlashCard.objects.update_or_create(
            id=FLASHCARD_ID,
            defaults={
                "stack": stack,
                "front": "Was ist eine Liste in Python?",
                "back": "Eine geordnete, veränderbare Sequenz von Werten.",
                "level_of_knowledge": 2,
            },
        )
