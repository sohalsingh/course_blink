import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search"
export default class extends Controller {
  connect() {
  }

  search(e) {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, 200)
  }
}
