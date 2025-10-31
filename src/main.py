import flet as ft

def main(page: ft.Page):
    page.title = "Fitness Club Accounting System"
    page.vertical_alignment = ft.MainAxisAlignment.CENTER

    # Simple welcome message and button
    def on_click(e):
        page.add(ft.Text("Welcome to Fitness Club App!", size=20, color="green"))

    page.add(
        ft.Text("Hello, Flet!", size=30, weight=ft.FontWeight.BOLD),
        ft.ElevatedButton("Click me", on_click=on_click)
    )

# Run the app
ft.app(target=main)
