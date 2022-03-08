import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ["feedbacks", "form"];
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
          this.feedbacksTarget.insertAdjacentHTML(this.positionValue, data.inserted_item)
        }
        this.formTarget.outerHTML = data.form
      })
  }
  patch(event) {
    event.preventDefault()
    fetch(this.formTarget.action, {
      method: "PATCH",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        if (data.inserted_item) {
          this.feedbacksTarget.insertAdjacentHTML(this.positionValue, data.inserted_item)
        }
        this.formTarget.outerHTML = data.form
      })
  }
}
