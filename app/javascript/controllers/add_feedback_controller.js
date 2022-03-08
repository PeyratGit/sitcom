import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ["feedbacks", "form", "rating", "comment", "formEdit", "user_feedback_partial"];
  static values = { position: String }

  connect() {
  }
  send(event) {
    event.preventDefault()
    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        if (data.inserted_item) {
          console.log(data)
          this.feedbacksTarget.insertAdjacentHTML(this.positionValue, data.inserted_item)
        }
        this.formTarget.outerHTML = data.form
    })
  }
  displayForm() {
    this.formEditTarget.classList.toggle("d-none")
  }
  update(event) {
    event.preventDefault()
    const url = this.formEditTarget.action
    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "text/plain", "X-CSRF-Token": csrfToken() },
      body: new FormData(this.formEditTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.user_feedback_partialTarget.innerHTML = data
      })
  }
}
