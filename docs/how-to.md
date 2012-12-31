# How to broadcast

## Scheduling broadcasts

* Go to the control panel at `http://HOST:PORT/`, where `HOST` defaults to your
  server's IP address and `PORT` defaults to `8000`, unless you've changed
  those settings in `backend/setup/setup.sh` before setting up your server.
* Log in with Twitter or Google using the links in the control panel. Your
  account must be authorized ahead of time; see
  `backend/credentials/oauth/contents.md` for more details of how to do this.
* If you're creating a new broadcast, enter a name, start date/time and
  duration in the "Broadcast Schedule" section of the control panel, then go to
  the "Sending events" section of this document.
* If you're rebroadcasting something you've broadcast before, simply enter the
  date/time when the rebroadcast should start in that broadcast's existing row
  in the "Broadcast Schedule" section of the control panel.

## Sending events

* You can create your own control panel to send events (URL changes) to meet
  your needs, but an example one exists at
  `http://HOST:PORT/examples/control.html?networked=broadcaster`, where `HOST`
  and `PORT` have the same values as described in the "Scheduling broadcasts"
  section of this document. The rest of this section will assume you're using
  that example control panel.
* Ensure you're logged in (using the Twitter and Google login links as
  appropriate). See the warning in the "Scheduling broadcasts" section of this
  document if you're having trouble logging in.
* Click the "Add page" link at the bottom of the page to add fields for URLs
  you'd like to send throughout the broadcast.
* Enter the URLs you'd like to send in each of these fields. You can use the
  arrows to the left of each field to reorder them.
* When you're ready to broadcast, click the "Start Broadcasting" button toward
  the top of the page under "Backend controls". You should be close to a
  scheduled broadcast time you planned as in the "Scheduling broadcasts"
  section of this document. (It's OK if you click "Start Broadcasting" before
  the broadcast is scheduled to start; any events you send before the
  scheduled start time will be ignored.)
* Click the "Send" link next to any of the URLs you entered to send that URL
  to viewers. A link may be sent as many times as you want, but sending it
  multiple times in a row (without any other URL in between) will be ignored.

## Receiving events

* You'll obviously want to create your own page to receive these events as
  they're broadcast. There's a very basic example at
  `http://HOST:PORT/examples/listener.html?networked=true`, where `HOST` and
  `PORT` have the same values as described in the "Scheduling broadcasts"
  section of this document.
* The example page illustrates the two things you need in order for this to
  work:
  
  * You need to include jQuery and the built `livemap.js` file.
  * You need to add a `change` event handler using `liveMap.status.on`. The
    handler's second argument will be the `status` object; `status.href` is the
    URL that was sent out. The example page's event handler just changes a
    paragraph's text to display the URL whenever it changes; you'll almost
    certainly want to change the `src` attribute of an `<iframe>` or something
    similar.
* You'll have to add the `?networked=true` to the URL of this page; it's just
  how the connection code is structured right now.
