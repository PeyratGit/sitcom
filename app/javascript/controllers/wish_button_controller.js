import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["wishlistbtn"]

  addOrRemoveWishlist() {
    this.wishlistbtnTarget.click();
  }

}
