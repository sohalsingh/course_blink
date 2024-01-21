import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="google-search"
export default class extends Controller {
  static targets = ["searchURL"]

  connect() {

    if (!this.searchURLTarget.value) {
      alert("There was some error please try again later.")
      return;
    }

    this.loadGoogleSearchScript();
  }

  loadGoogleSearchScript() {
    const url = this.searchURLTarget.value;

    const script = document.createElement('script');
    script.src = url;
    script.async = true;
    script.id = 'google-search-script';

    script.onload = () => {
      console.log('External script loaded successfully!');
      // You can trigger additional actions or modify the DOM as needed here
    };

    script.onerror = () => {
      console.error('Error loading external script.');
      // Handle error if necessary
    };

    document.head.appendChild(script);

  }

  disconnect() {
    const script = document.getElementById('google-search-script');
    if (script) {
      script.remove();
    }
  }

}
