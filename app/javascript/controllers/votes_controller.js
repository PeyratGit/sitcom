import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["likebtn", "dislikebtn", "superlikebtn", "scores"];

  connect() {
  }
  changescores(event) {
    // this.scoresTarget.innerHTML = event.detail[0].response
  }
}
