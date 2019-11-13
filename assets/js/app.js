// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

import { Socket } from "phoenix"
import LiveSocket from "phoenix_live_view"

// let liveSocket = new LiveSocket("/live", Socket)
// liveSocket.connect()

let Hooks = {}

const scrollToBottomByElement = (element) => {
  if (element) {
    element.scrollTop = element.scrollHeight
  }
}

Hooks.NewComment = {
  mounted() {
    const elm = document.getElementById("msg-container");
    scrollToBottomByElement(elm);
    elm.onscroll = (e) => {
      this.pushEvent("scroll_change",{value: elm.scrollTop});
    }
  },
  updated() {
    scrollToBottomByElement(document.getElementById("msg-container"));
    // this.pushEvent("some_event",{});
  }
}

let liveSocket = new LiveSocket("/live", Socket, { hooks: Hooks })
liveSocket.connect()
