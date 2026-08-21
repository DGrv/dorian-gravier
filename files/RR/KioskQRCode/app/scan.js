/*
 * scan.js — adds a camera QR scan button to the RACE RESULT kiosk hosted by
 * index.html on this origin.
 *
 * Because the kiosk builds its DOM in OUR document, no same-origin restriction
 * applies: we set the kiosk's own search input and dispatch 'change', which is
 * exactly what typing does (kiosk.js: l.onchange = function(){ c(this.value) }).
 * The kiosk performs the lookup and every following step is untouched.
 *
 * Nothing here is event-specific, so one deploy serves any kiosk.
 */
(function () {
  if (window.__kioskQr) return;
  window.__kioskQr = true;

  var MARK = 'data-kiosk-qr';
  var SEL = 'input[type="search"]';

  /* --- value handling ---------------------------------------------------- */

  // Kiosk search is a substring match across BIB, LASTNAME, FIRSTNAME,
  // CONTEST.NAME and CLUB, so scanning "4" also matches club "Mountain4life".
  // Comparing normalised values lets us pick the row whose BIB is an exact
  // match, and makes zero-padded payloads ("0004") resolve to bib 4.
  function norm(v) {
    v = String(v == null ? '' : v).trim();
    return /^\d+$/.test(v) ? String(parseInt(v, 10)) : v.toLowerCase();
  }

  function input() { return document.querySelector(SEL); }

  // kiosk.js renders each hit as <tr> with td[0] = bib and tr.onclick selecting
  // it. Clicking is therefore the same action as a volunteer tapping the row.
  function pickExact(value) {
    var rows = document.querySelectorAll('tr');
    for (var i = 0; i < rows.length; i++) {
      var td = rows[i].querySelector('td');
      if (td && norm(td.textContent) === norm(value) && rows[i].onclick) {
        rows[i].click();
        return true;
      }
    }
    return false;
  }

  // Exposed for testing and for driving the page from the console.
  window.__kioskQrResult = function (code) {
    var el = input();
    if (!el) return;
    var v = String(code == null ? '' : code).trim();
    if (!v) return;
    el.focus();
    el.value = v;
    el.dispatchEvent(new Event('input', { bubbles: true }));
    el.dispatchEvent(new Event('change', { bubbles: true }));

    // The search is async; poll briefly for rows, then auto-select the exact
    // bib. If there is no exact match the list is left for a manual tap.
    var tries = 0;
    (function wait() {
      if (pickExact(v)) return;
      if (++tries < 30) setTimeout(wait, 100);
      else toast('Scanned ' + v + ' — pick the right row');
    })();
  };

  /* --- tiny UI ----------------------------------------------------------- */

  function toast(msg) {
    var t = document.createElement('div');
    t.textContent = msg;
    t.style.cssText = 'position:fixed;left:50%;bottom:24px;transform:translateX(-50%);' +
      'background:#1c364b;color:#fff;padding:12px 18px;border-radius:6px;z-index:100000;' +
      'font:16px system-ui,sans-serif;max-width:90vw;text-align:center';
    document.body.appendChild(t);
    setTimeout(function () { t.remove(); }, 3500);
  }

  /* --- camera ------------------------------------------------------------ */

  var stream = null, raf = null, overlay = null, detector = null;

  function stop() {
    if (raf) { cancelAnimationFrame(raf); raf = null; }
    if (stream) { stream.getTracks().forEach(function (t) { t.stop(); }); stream = null; }
    if (overlay) { overlay.remove(); overlay = null; }
  }

  function open() {
    if (overlay) return;
    overlay = document.createElement('div');
    overlay.style.cssText = 'position:fixed;inset:0;background:#000;z-index:99999;' +
      'display:flex;flex-direction:column;align-items:center;justify-content:center';

    var video = document.createElement('video');
    video.setAttribute('playsinline', '');   // iOS Safari will not play inline without this
    video.muted = true;
    video.autoplay = true;
    video.style.cssText = 'max-width:100%;max-height:78vh';
    overlay.appendChild(video);

    var bar = document.createElement('div');
    bar.style.cssText = 'display:flex;gap:12px;margin-top:16px';
    overlay.appendChild(bar);

    function btn(label, fn) {
      var b = document.createElement('button');
      b.type = 'button';
      b.textContent = label;
      b.style.cssText = 'padding:14px 22px;font-size:17px;border:0;border-radius:6px;' +
        'background:#eae3de;color:#1c364b';
      b.onclick = fn;
      bar.appendChild(b);
      return b;
    }
    btn('Cancel', stop);

    document.body.appendChild(overlay);

    navigator.mediaDevices.getUserMedia({
      video: { facingMode: { ideal: 'environment' } }, audio: false
    }).then(function (s) {
      stream = s;
      video.srcObject = s;

      // Torch helps with creased printouts in a dim hall; not all devices offer it.
      var track = s.getVideoTracks()[0];
      var caps = track && track.getCapabilities ? track.getCapabilities() : null;
      if (caps && caps.torch) {
        var on = false;
        btn('🔦 Light', function () {
          on = !on;
          track.applyConstraints({ advanced: [{ torch: on }] });
        });
      }
      return video.play();
    }).then(function () {
      loop(video);
    }).catch(function (e) {
      stop();
      toast('Camera unavailable: ' + (e && e.name ? e.name : e));
    });
  }

  function found(code) {
    stop();
    window.__kioskQrResult(code);
  }

  function loop(video) {
    var canvas = document.createElement('canvas');
    var ctx = canvas.getContext('2d', { willReadFrequently: true });

    // BarcodeDetector is native and cheap where it exists (Android Chrome);
    // jsQR is the fallback that covers iOS Safari.
    if (!detector && window.BarcodeDetector) {
      try { detector = new BarcodeDetector({ formats: ['qr_code'] }); } catch (e) { detector = null; }
    }

    function tick() {
      if (!stream) return;
      raf = requestAnimationFrame(tick);
      if (video.readyState !== 4) return;

      if (detector) {
        if (tick.busy) return;
        tick.busy = true;
        detector.detect(video).then(function (r) {
          tick.busy = false;
          if (r && r.length) found(r[0].rawValue);
        }).catch(function () { tick.busy = false; detector = null; });
        return;
      }

      if (typeof jsQR !== 'function') return;
      canvas.width = video.videoWidth;
      canvas.height = video.videoHeight;
      if (!canvas.width) return;
      ctx.drawImage(video, 0, 0);
      var img = ctx.getImageData(0, 0, canvas.width, canvas.height);
      var res = jsQR(img.data, img.width, img.height, { inversionAttempts: 'dontInvert' });
      if (res && res.data) found(res.data);
    }
    tick();
  }

  /* --- button injection -------------------------------------------------- */

  function decorate(el) {
    if (el.getAttribute(MARK)) return;
    el.setAttribute(MARK, '1');
    var b = document.createElement('button');
    b.type = 'button';
    b.textContent = '📷 Scan QR code';
    b.style.cssText = 'display:block;width:100%;margin:8px 0;padding:16px;font-size:18px;' +
      'border:0;border-radius:6px;background:#1c364b;color:#eae3de';
    b.onclick = open;
    el.parentNode.insertBefore(b, el.nextSibling);
  }

  function sweep() {
    var l = document.querySelectorAll(SEL);
    for (var i = 0; i < l.length; i++) decorate(l[i]);
  }

  // The kiosk is a SPA: the search input does not exist when this runs, and is
  // rebuilt as steps change.
  sweep();
  new MutationObserver(sweep).observe(document.documentElement,
    { childList: true, subtree: true });
})();
