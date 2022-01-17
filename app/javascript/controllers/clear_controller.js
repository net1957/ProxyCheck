import {Controller} from "@hotwired/stimulus"

// remove all errors dom attributes
export default class extends Controller {
  static targets = ["error"]

  clear_error() {
    this.errorTargets.forEach(
      (el) => {el.remove()}
    )
    for (const el of this.element.querySelectorAll(".is-danger")) {
      el.classList.replace("is-danger", "is-success")
    }
    for (const el of this.element.querySelectorAll("p", ".is-danger")) {
      el.remove()
    }
    for (const el of this.element.querySelectorAll(".notification")) {
      el.remove()
    }
  }

  clear_url() {
    document.getElementById("forms_script_url").value = ""
  }
  clear_name() {
    document.getElementById("forms_script_name").value = ""
  }
}
