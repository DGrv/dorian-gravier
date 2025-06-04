L.Control.MousePosition = L.Control.extend({
  options: {
    position: 'bottomleft',
    separator: ',',
    emptyString: 'Unavailable',
    lngFirst: false,
    numDigits: 6,
    lngFormatter: undefined,
    latFormatter: undefined,
    prefix: "Ctrl+c to copy: "
  },

  onAdd: function (map) {
    this._container = L.DomUtil.create('div', 'leaflet-control-mouseposition');
    L.DomEvent.disableClickPropagation(this._container);
    this._container.setAttribute('tabindex', '0'); // Make focusable
    this._container.style.userSelect = 'text';     // Make text selectable

    map.on('mousemove', this._onMouseMove, this);

    // Optional: store current value
    this._currentValue = this.options.emptyString;
    this._container.innerHTML = this._currentValue;

    // Add keydown listener
    document.addEventListener('keydown', (e) => {
      if (e.ctrlKey && e.key.toLowerCase() === 'c') {
        navigator.clipboard.writeText(this._currentValue).then(() => {
          console.log('Coordinates copied:', this._currentValue);
        }).catch(err => {
          console.warn('Clipboard write failed', err);
        });
      }
    });

    return this._container;
  },

  onRemove: function (map) {
    map.off('mousemove', this._onMouseMove, this);
  },

  _onMouseMove: function (e) {
    var lng = this.options.lngFormatter
      ? this.options.lngFormatter(e.latlng.lng)
      : L.Util.formatNum(e.latlng.lng, this.options.numDigits);
    var lat = this.options.latFormatter
      ? this.options.latFormatter(e.latlng.lat)
      : L.Util.formatNum(e.latlng.lat, this.options.numDigits);
    var value = this.options.lngFirst
      ? lng + this.options.separator + lat
      : lat + this.options.separator + lng;
    var prefixAndValue = this.options.prefix + ' ' + value;

    this._currentValue = value; // Save without prefix for clipboard
    this._container.innerHTML = prefixAndValue;
  }
});


// Original
// L.Control.MousePosition = L.Control.extend({
//   options: {
//     position: 'bottomleft',
//     separator: ' : ',
//     emptyString: 'Unavailable',
//     lngFirst: false,
//     numDigits: 5,
//     lngFormatter: undefined,
//     latFormatter: undefined,
//     prefix: ""
//   },

//   onAdd: function (map) {
//     this._container = L.DomUtil.create('div', 'leaflet-control-mouseposition');
//     L.DomEvent.disableClickPropagation(this._container);
//     map.on('mousemove', this._onMouseMove, this);
//     this._container.innerHTML=this.options.emptyString;
//     return this._container;
//   },

//   onRemove: function (map) {
//     map.off('mousemove', this._onMouseMove)
//   },

//   _onMouseMove: function (e) {
//     var lng = this.options.lngFormatter ? this.options.lngFormatter(e.latlng.lng) : L.Util.formatNum(e.latlng.lng, this.options.numDigits);
//     var lat = this.options.latFormatter ? this.options.latFormatter(e.latlng.lat) : L.Util.formatNum(e.latlng.lat, this.options.numDigits);
//     var value = this.options.lngFirst ? lng + this.options.separator + lat : lat + this.options.separator + lng;
//     var prefixAndValue = this.options.prefix + ' ' + value;
//     this._container.innerHTML = prefixAndValue;
//   }

// });

L.Map.mergeOptions({
    positionControl: false
});

L.Map.addInitHook(function () {
    if (this.options.positionControl) {
        this.positionControl = new L.Control.MousePosition();
        this.addControl(this.positionControl);
    }
});

L.control.mousePosition = function (options) {
    return new L.Control.MousePosition(options);
};
