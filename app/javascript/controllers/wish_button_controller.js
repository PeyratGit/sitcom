import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["inwishlistbtn", "outofwishlistbtn"]

  connect() {
    console.log(this.inwishlistbtnTarget)
    console.log(this.outofwishlistbtnTarget)
  }

  // removeFromWishlistChangeIcon() {
  //   // changeIcon
  //   this.inwishlistTarget.classList.remove("fa-heart")
  //   this.inwishlistTarget.classList.add("fa-heart-o")
  // }

  addOrRemoveWishlist() {
    // if (document.getElementById('.fa-heart-o') {
    //   this.inwishlistbtnTarget.click()
    // } else {
    //   this.inwishlistbtnTarget.click()
    // }

  }

  // addToWishlistChangeIcon() {
  //   // changeIcon
  //   this.notinwishlistTarget.classList.remove("fa-heart-o")
  //   this.notinwishlistTarget.classList.add("fa-heart")
  //   this.inwishlistbtnTarget.click()
  // }
}
