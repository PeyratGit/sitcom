import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["likebtn", "dislikebtn", "superlikebtn", "scores", "likes", "superlikes", "dislikes"];

  connect() {
    if (this.targets) {
      console.log(this.likebtnTarget)
      console.log(this.dislikebtnTarget)
      console.log(this.superlikebtnTarget)
      console.log(this.scoresTarget);
    }
  }
  changescores(event) {
    console.log(event)
  }
  like(event) {
    event.preventDefault();
    
    // this.likesTarget.innerText = parseInt(this.likesTarget.innerText) + 1;
    // if (parseInt(this.dislikesTarget.innerText) > 0) {
    //   this.dislikesTarget.innerText = parseInt(this.dislikesTarget.innerText) - 1;
    // };
    // if (parseInt(this.superlikesTarget.innerText) > 0) {
    //   this.superlikesTarget.innerText = parseInt(this.superlikesTarget.innerText) - 1;
    // };
  }
  dislike(event) {
    console.log("salut")
  }
  superlike(event) {
    console.log("salut")
  }
}
