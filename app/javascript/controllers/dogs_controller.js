import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dogs"
export default class extends Controller {
  fetchDog(e) {
    e.preventDefault();
    const form = e.target;
    const formData = new FormData(form);
    const breed = formData.get('breed');
    const csrfToken = document.head.querySelector('meta[name="csrf-token"]').content;
    const headers = new Headers({
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken,
    });
    fetch("/fetch_dog", {
      headers: headers,
      method: "POST",
      body: JSON.stringify({ breed: breed })})
        .then(response => response.text())
        .then(html => {
          document.getElementById('result').innerHTML = html;
        });
  }
}
