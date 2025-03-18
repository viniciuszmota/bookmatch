import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reset-form"
export default class extends Controller {
  static targets = ["form", "input"]
  connect() {
    this.inputTarget.addEventListener("keydown", this.handleKeydown.bind(this));
  }

  disconnect(){
    this.inputTarget.removeEventListener("keydown", this.handleKeydown.bind(this));
  }

  handleKeydown(event) {
    
    if (event.key === "Enter" && !event.shiftKey) { 
      event.preventDefault();  // Impede a quebra de linha
      this.formTarget.submit();  // Envia o formulário
    }
  }
  reset(event) {
    event.preventDefault()

    this.formTarget.reset()

    this.inputTarget.value = ""
  }
}
