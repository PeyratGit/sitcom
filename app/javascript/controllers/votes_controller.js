import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["likebtn", "dislikebtn", "superlikebtn"];

  connect() {
    if (this.targets) {
      console.log(this.likebtnTarget)
      console.log(this.dislikebtnTarget)
      console.log(this.superlikebtnTarget)
    }
  }
}
