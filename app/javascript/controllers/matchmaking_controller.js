import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="matchmaking"
export default class extends Controller {
  static targets = ["book", "formLike", "formDislike"]
  connect() {
    this.startX = 0;
    this.currentBook = this.bookTargets[0];

    this.currentBook.addEventListener("touchstart", (e) => this.startTouch(e));
    this.currentBook.addEventListener("touchmove", (e) => this.moveTouch(e));
    this.currentBook.addEventListener("touchend", (e) => this.endTouch(e));
  }

  endTouche(event) {
    let touchX = event.changedTouches[0].clientX;
    let deltaX = touchX - this.startX;

    if (deltaX > 100) {
      this.like();
    } else if (deltaX < -100) {
      this.dislike();
    } else {
      this.currentBook.style.transform = "translateX(0) rotate(0)";
    }
  }

  like() {
    this.currentBook.style.transform = "translate(300px) rotate(20deg)";
    this.currentBook.style.opacity = "0";

    setTimeout(() => {
      this.formLikeTarget.requestSubmit();
    }, 300);
  }

  dislike() {
    this.currentBook.style.transform = "translateX(-300px) rotate(-20deg)";
    this.currentBook.style.opacity = "0"; 

    setTimeout(() => {
      this.formDislikeTarget.requestSubmit();
    }, 300);
  }
}
