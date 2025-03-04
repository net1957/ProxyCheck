// see: https://www.wmbt.services/blog/dark-mode-rails-stimulus

import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["themeBtn"]

  // set theme at page loading
  connect() {
    const theme = this.updateTheme()
    this.setSelected(theme)
  }

  // selection of theme on UI
  toggle() {
    const theme = this.themeBtnTargets[0].value
    if (theme === "auto") {document.cookie = `theme=; path=/;max-age=-1;`}
      else {document.cookie = `theme=${theme}; path=/;`}
    this.updateTheme()
  }

  // set the theme of bulma
  updateTheme() {
    const theme = this.currentTheme()
    const htmlElement = document.querySelector(":root")
    if (theme === "auto") {delete htmlElement.dataset.theme}
      else {htmlElement.dataset.theme = theme}
    return theme
  }

  // get theme from cookie
  currentTheme() {
    const matches = document.cookie.match(/theme=([^;]+)/)
    return matches ? matches[1] : "auto"
  }

  // set the theme on the select (needed at page loading)
  setSelected(theme) {
    this.themeBtnTargets.forEach(
      (el) => {el.value = theme}
    )
  }
}
