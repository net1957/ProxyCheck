import {Controller} from "@hotwired/stimulus"

// see https://bulma.io/documentation/components/navbar/
export default class extends Controller {
  static targets = ["menu"]

  toggle() {
    this.menuTargets.forEach(
      (el) => {el.classList.toggle("is-active")}
    )
  }
}
