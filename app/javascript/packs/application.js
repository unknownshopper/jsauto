// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "chartkick"
import { Chart } from "chart.js"
import { registerables } from 'chart.js'
import "chartjs-adapter-date-fns"

// Registrar todos los controladores de Chart.js
Chart.register(...registerables)

// Registrar Chart.js con Chartkick
window.Chartkick.use(Chart)

Rails.start()
Turbolinks.start()
ActiveStorage.start()
