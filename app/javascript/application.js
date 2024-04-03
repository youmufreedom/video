// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import Video from "video.js"
import "video.js/dist/video-js.css"

document.addEventListener("turbo:load", () => {
  document.querySelectorAll('.video-js').forEach((element) => {
    Video(element);
  });
});

import Dropzone from "dropzone"
Dropzone.autoDiscover = false;

document.addEventListener("DOMContentLoaded", () => {
  const dropzone = new Dropzone("#video-dropzone", {
    paramName: "video[file]", // The name that will be used to transfer the file
    maxFilesize: 3072, // MB
    timeout: 180000, // milliseconds
  });

  dropzone.on("totaluploadprogress", function(progress) {
    console.log("Upload Progress:", progress);
  });
});
