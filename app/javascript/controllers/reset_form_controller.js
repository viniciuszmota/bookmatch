import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reset-form"
export default class extends Controller {
  static targets = ["form"]
  connect() {
  }
  reset() {
    this.formTarget.reset()
  }
}