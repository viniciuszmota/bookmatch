import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="message"
export default class extends Controller {
  static values = { userId: Number }
  connect() {
    console.log('conectado')
    // triggered when a new message is added to the page
    const currentUserId = parseInt(document.body.dataset.currentUserId, 10);
    console.log(this.userIdValue)
    console.log(currentUserId)
    if (this.userIdValue === currentUserId) {
      this.element.classList.add('message-sent');
      this.element.classList.remove('message-received');
    } else {
      this.element.classList.add('message-received');
      this.element.classList.remove('message-sent');
    }
    this.element.scrollIntoView({ behavior: 'smooth' }); // scroll to the bottom of the page
  }
}