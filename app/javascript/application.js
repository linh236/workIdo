// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import jQuery from "jquery";
import * as ActiveStorage from "@rails/activestorage";

// Make jQuery global
window.$ = window.jQuery = jQuery;
ActiveStorage.start();

import autosize from 'autosize';
import "trix"
import "@rails/actiontext"

autosize($('textarea'));

