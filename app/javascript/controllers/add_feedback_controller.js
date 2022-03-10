import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ["feedbacks", "form", "rating", "comment", "formEdit", "user_feedback_partial", "feedbacks_number"];
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
        this.formTarget.classList.add("d-none")
        let feedback_string = this.feedbacks_numberTarget.innerText.split(' ')
        feedback_string[0] = parseInt(feedback_string[0]) + 1
        if (feedback_string[0] > 1) {
          feedback_string[1] = "Feedbacks"
        };
        this.feedbacks_numberTarget.innerText = feedback_string.join(' ')
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
