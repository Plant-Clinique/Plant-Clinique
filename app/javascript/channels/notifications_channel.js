import consumer from "./consumer"
import CableReady from 'cable_ready'

consumer.subscriptions.create("NotificationsChannel", {
  received(data) {
    // Called when there's incoming data on the websocket for this channel
    if (data.cableReady) CableReady.perform(data.operations)
    console.log("The following data was received:")
    console.log(data)
    console.log(ASFAF+ss)
  }
});
