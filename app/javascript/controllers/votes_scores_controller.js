import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["likescore", "dislikescore", "superlikescore"];

  connect() {
    if (this.targets) {
      console.log(this.likescoreTarget);
      console.log(this.dislikescoreTarget);
      console.log(this.superlikescoreTarget);
    };
  }
  testfunction(event) {
    console.log(event.detail[2].responseURL);
  }
}
