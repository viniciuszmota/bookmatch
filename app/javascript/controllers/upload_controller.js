import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="upload"
export default class extends Controller {
  static targets = ["label"]
  connect() {
    console.log("foi");
  }

  updateLabel(event) {
    console.log(event);
    const file = event.target.files[0];
    console.log(`arquivo: ${file.name}`);
    this.labelTarget.textContent = file ? file.name : "Selecione uma foto";

  }
}
