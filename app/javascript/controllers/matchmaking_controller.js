import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="matchmaking"
export default class extends Controller {
  static targets = ["bookCardMatching"]  // Define o alvo do livro que vai ser exibido e animado

  connect() {
    console.log("Matchmaking conectado!");

    // Se houver um livro a ser exibido, aplique a animação de match
    if (this.bookCardMatchingTargets.length > 0) {
      this.showMatchingBooks();
    }
  }

  showMatchingBooks() {
    // Obtém os livros
    const bookCards = this.bookCardMatchingTargets;

    // Adiciona a classe para animar os livros
    bookCards.forEach(bookCard => {
      // Adiciona um pequeno delay para suavizar a animação
      setTimeout(() => {
        bookCard.classList.add("match-active");
      }, 500); // Delay de 500ms antes de aplicar a animação
    });

    // Garantir que o display dos livros seja visível
    setTimeout(() => {
      bookCards.forEach(bookCard => {
        bookCard.style.display = "block";  // Faz os livros aparecerem
      });
    }, 500); // Ajuste o delay conforme necessário para que a animação de fade-in funcione
  }
}
