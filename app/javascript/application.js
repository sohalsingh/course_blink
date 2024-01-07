// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "preline/dist/preline"
import "./dark_mode"
import './companion'

document.addEventListener("turbo:load", function (event) {
  HSStaticMethods.autoInit();
});
