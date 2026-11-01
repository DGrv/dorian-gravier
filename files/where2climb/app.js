// Fill in your free meteoblue API key here.
const METEOBLUE_API_KEY = "uBQRdWhsJvMZ1SDf";

const STORAGE_KEY = "meteoblue_pins";

// Meteoblue's Picture API gives you a pre-filled meteogram URL on your
// account dashboard (my.meteoblue.com -> Picture API). Paste the exact
// query-param set they give you here, swapping the lat/lon/asl values for
// the template placeholders below. This default covers the common case.
// Note: this free image endpoint has no documented dark-background param,
// so the dark look is applied via a CSS filter on the <img> instead.
function buildMeteogramUrl(lat, lng, city) {
  const params = new URLSearchParams({
    apikey: METEOBLUE_API_KEY,
    lat: lat.toFixed(4),
    lon: lng.toFixed(4),
    // asl omitted on purpose: meteoblue fills real elevation from its own
    // elevation model when asl isn't passed.
    city: city || "",
    temperature: "C",
    windspeed: "kmh",
    winddirection: "degree",
    precipitationamount: "mm",
    timeformat: "dd.mm",
    coloured: "coloured",
    numberofdays: 7,
  });
  return `https://my.meteoblue.com/images/meteogram?${params.toString()}`;
}

const AUTOOPEN_KEY = "meteoblue_autoopen";

function loadAutoOpen() {
  return localStorage.getItem(AUTOOPEN_KEY) === "true";
}

function saveAutoOpen(value) {
  localStorage.setItem(AUTOOPEN_KEY, value ? "true" : "false");
}

let currentLightboxId = null;

function openLightboxForPin(pinId) {
  const pin = pins.find((p) => p.id === pinId);
  if (!pin) return;
  const lightbox = document.getElementById("lightbox");
  const img = document.getElementById("lightbox-img");
  const title = document.getElementById("lightbox-title");
  img.src = buildMeteogramUrl(pin.lat, pin.lng, pin.city);
  img.alt = `Meteogram for ${pin.name}`;
  title.textContent = pin.name;
  currentLightboxId = pin.id;
  lightbox.classList.remove("hidden");
}

// Reverse-geocode via Nominatim (free, no key) so the meteogram's city
// label reflects the real place at those coordinates, not whatever the
// user typed for the pin's own sidebar label.
async function reverseGeocodeCity(lat, lng) {
  const url = `https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lng}&zoom=14&addressdetails=1`;
  try {
    const res = await fetch(url);
    const data = await res.json();
    const a = data.address || {};
    return (
      a.city || a.town || a.village || a.hamlet || a.suburb ||
      (data.display_name ? data.display_name.split(",")[0] : "")
    );
  } catch (e) {
    return "";
  }
}

function navigateLightbox(delta) {
  if (currentLightboxId == null || pins.length === 0) return;
  const idx = pins.findIndex((p) => p.id === currentLightboxId);
  if (idx === -1) return;
  const nextIdx = (idx + delta + pins.length) % pins.length;
  openLightboxForPin(pins[nextIdx].id);
}

function loadPins() {
  try {
    return JSON.parse(localStorage.getItem(STORAGE_KEY)) || [];
  } catch (e) {
    return [];
  }
}

function savePins(pins) {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(pins));
}

const map = L.map("map", { zoomControl: false }).setView([46.8, 8.2], 7);
L.control.zoom({ position: "bottomleft" }).addTo(map);

L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
  attribution: "&copy; OpenStreetMap contributors",
  maxZoom: 19,
}).addTo(map);

const markersById = new Map();
let pins = loadPins();

function popupContent(pin) {
  const div = document.createElement("div");
  div.className = "meteogram-popup";

  const title = document.createElement("strong");
  title.textContent = pin.name;
  div.appendChild(title);

  const img = document.createElement("img");
  img.src = buildMeteogramUrl(pin.lat, pin.lng, pin.city);
  img.alt = `Meteogram for ${pin.name}`;
  img.onclick = (e) => {
    e.stopPropagation();
    openLightboxForPin(pin.id);
  };
  div.appendChild(img);

  const delBtn = document.createElement("button");
  delBtn.className = "delete-pin";
  delBtn.textContent = "Delete pin";
  delBtn.onclick = () => removePin(pin.id);
  div.appendChild(delBtn);

  return div;
}

function addMarker(pin) {
  const marker = L.marker([pin.lat, pin.lng]).addTo(map);
  marker.bindPopup(popupContent(pin), {
    closeButton: true,
    autoClose: false,
    closeOnClick: false,
    closeOnEscapeKey: false,
  });
  if (loadAutoOpen()) {
    marker.openPopup();
  }
  markersById.set(pin.id, marker);
}

function renderSidebar() {
  const list = document.getElementById("sidebar-list");
  list.innerHTML = "";

  pins.forEach((pin) => {
    const card = document.createElement("div");
    card.className = "sidebar-card";

    const header = document.createElement("div");
    header.className = "card-header";

    const name = document.createElement("strong");
    name.textContent = pin.name;
    header.appendChild(name);

    const delBtn = document.createElement("button");
    delBtn.className = "delete-pin";
    delBtn.textContent = "Delete";
    delBtn.onclick = () => removePin(pin.id);
    header.appendChild(delBtn);

    card.appendChild(header);

    const img = document.createElement("img");
    img.src = buildMeteogramUrl(pin.lat, pin.lng, pin.city);
    img.alt = `Meteogram for ${pin.name}`;
    img.onclick = () => openLightboxForPin(pin.id);
    card.appendChild(img);

    list.appendChild(card);
  });
}

async function addPin(name, lat, lng) {
  const city = await reverseGeocodeCity(lat, lng);
  const pin = {
    id: Date.now().toString(36),
    name,
    lat,
    lng,
    city,
  };
  pins.push(pin);
  savePins(pins);
  addMarker(pin);
  renderSidebar();
}

function removePin(id) {
  pins = pins.filter((p) => p.id !== id);
  savePins(pins);
  const marker = markersById.get(id);
  if (marker) {
    map.removeLayer(marker);
    markersById.delete(id);
  }
  renderSidebar();
}

pins.forEach(addMarker);
renderSidebar();

function removeAllPins() {
  if (!pins.length) return;
  if (!confirm(`Delete all ${pins.length} saved places?`)) return;
  markersById.forEach((marker) => map.removeLayer(marker));
  markersById.clear();
  pins = [];
  savePins(pins);
  renderSidebar();
}

document.getElementById("delete-all-btn").addEventListener("click", removeAllPins);

map.on("click", async (e) => {
  const name = prompt("Name this location:");
  if (!name) return;
  await addPin(name, e.latlng.lat, e.latlng.lng);
});

// --- city search (Nominatim, no key needed) ---
const searchInput = document.getElementById("search-input");
const searchResults = document.getElementById("search-results");
let searchTimer = null;

searchInput.addEventListener("input", () => {
  const q = searchInput.value.trim();
  clearTimeout(searchTimer);

  if (q.length < 3) {
    searchResults.classList.remove("open");
    searchResults.innerHTML = "";
    return;
  }

  searchTimer = setTimeout(() => runSearch(q), 350);
});

async function runSearch(q) {
  const url = `https://nominatim.openstreetmap.org/search?format=json&limit=6&q=${encodeURIComponent(q)}`;
  let data;
  try {
    const res = await fetch(url);
    data = await res.json();
  } catch (e) {
    searchResults.innerHTML = '<div class="result-item">Search failed</div>';
    searchResults.classList.add("open");
    return;
  }

  searchResults.innerHTML = "";
  if (!data.length) {
    searchResults.innerHTML = '<div class="result-item">No results</div>';
    searchResults.classList.add("open");
    return;
  }

  data.forEach((result) => {
    const item = document.createElement("div");
    item.className = "result-item";
    item.textContent = result.display_name;
    item.onclick = () => {
      const lat = parseFloat(result.lat);
      const lng = parseFloat(result.lon);
      map.setView([lat, lng], 10);
      searchResults.classList.remove("open");
      searchResults.innerHTML = "";
      searchInput.value = "";
    };
    searchResults.appendChild(item);
  });
  searchResults.classList.add("open");
}

// --- auto-open popups checkbox ---
const autoopenCheckbox = document.getElementById("autoopen-checkbox");
autoopenCheckbox.checked = loadAutoOpen();
autoopenCheckbox.addEventListener("change", () => {
  saveAutoOpen(autoopenCheckbox.checked);
});

// --- lightbox close (click anywhere on the overlay) ---
document.getElementById("lightbox").addEventListener("click", () => {
  document.getElementById("lightbox").classList.add("hidden");
  currentLightboxId = null;
});

// --- lightbox keyboard navigation (left/right arrows cycle pins, Esc closes) ---
document.addEventListener("keydown", (e) => {
  const lightbox = document.getElementById("lightbox");
  if (lightbox.classList.contains("hidden")) return;

  if (e.key === "ArrowRight") {
    navigateLightbox(1);
  } else if (e.key === "ArrowLeft") {
    navigateLightbox(-1);
  } else if (e.key === "Escape") {
    lightbox.classList.add("hidden");
    currentLightboxId = null;
  }
});

// --- sidebar resize (drag handle) ---
const SIDEBAR_WIDTH_KEY = "meteoblue_sidebar_width";
const appEl = document.getElementById("app");
const sidebarEl = document.getElementById("sidebar");
const resizeHandle = document.getElementById("sidebar-resize-handle");

const savedWidth = parseInt(localStorage.getItem(SIDEBAR_WIDTH_KEY), 10);
if (savedWidth) {
  sidebarEl.style.width = `${savedWidth}px`;
}

let resizing = false;

resizeHandle.addEventListener("mousedown", (e) => {
  resizing = true;
  e.preventDefault();
});

document.addEventListener("mousemove", (e) => {
  if (!resizing) return;
  const newWidth = Math.min(
    Math.max(window.innerWidth - e.clientX, 240),
    window.innerWidth - 200
  );
  sidebarEl.style.width = `${newWidth}px`;
});

document.addEventListener("mouseup", () => {
  if (!resizing) return;
  resizing = false;
  localStorage.setItem(SIDEBAR_WIDTH_KEY, parseInt(sidebarEl.style.width, 10));
  map.invalidateSize();
});

// --- full-screen sidebar toggle (desktop button + mobile floating button) ---
function toggleSidebarFullscreen() {
  appEl.classList.toggle("sidebar-fullscreen");
  setTimeout(() => map.invalidateSize(), 0);
}

document.getElementById("fullscreen-toggle").addEventListener("click", toggleSidebarFullscreen);
document.getElementById("mobile-sidebar-toggle").addEventListener("click", toggleSidebarFullscreen);
