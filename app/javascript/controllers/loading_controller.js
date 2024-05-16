import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"
export default class extends Controller {
  static targets = ["spinner", "photo"]

  connect() {
    console.log("connect")
  }

  show() {
    console.log("show")
    this.spinnerTarget.classList.remove('hidden')
    this.photoTarget.classList.add("hidden")
  }

  hide() {
    console.log("hidden")
    this.spinnerTarget.classList.add('hidden')
    this.photoTarget.classList.remove("hidden")
  }

  disconnect() {
    this.hide()
  }
}
