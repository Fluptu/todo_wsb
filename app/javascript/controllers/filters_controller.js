import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filters"
export default class extends Controller {
  static get targets() {
    return ["form"]
  }

  submit(event){
    this.formTarget.requestSubmit()
  }
}
