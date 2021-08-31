'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "83756eb8bf4a5c97e12f4b2cfd6a5045",
"index.html": "5c960b3b5c911bcbdd345bfac991e46f",
"/": "5c960b3b5c911bcbdd345bfac991e46f",
"main.dart.js": "66164f61ee01b0a3eff6e9104a46cbba",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "a07b2fa3b8667f503241209b354e01b0",
"assets/AssetManifest.json": "f8d2bfd804a9abf61ea49ea61ec8869f",
"assets/NOTICES": "d750d2f031f7535042eadcc53a9d6e39",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/assets/style%2520guide.png": "3e05c02c0db42aebf400c09a53d7e46a",
"assets/assets/gallery%2520img%25201.png": "3725fd57ff68a6c615e8a735b346ef41",
"assets/assets/tokyo_bg.jpeg": "fcd0eac5f7a0ce021894a9c6fbc63167",
"assets/assets/tokyo_bg_2.png": "f64a27150ab9f7f1dac6aef6a5fc5a50",
"assets/assets/gallery%2520img%25202.png": "e412bd8db27384696f99b5e2c90f8404",
"assets/assets/gallery%2520img%25203.png": "551545f699c1b86cb59557c3c04326fd",
"assets/assets/tokyo_bg_1.png": "cdc37b100f6011536ef0833b6a9e1f46",
"assets/assets/icons/home_top_bg.svg": "beda809469a32cd0ee8307e7224f52d2",
"assets/assets/icons/home_bottom_bg.svg": "f6b4782920c2d30aa18332694c8f12d1",
"assets/assets/icons/Edit_fill.svg": "d8630df8d738a584ae24fa7c90f7fc46",
"assets/assets/icons/Favorite_fill.svg": "a9a23eabb88ec02e8daae4cc5d7e593b",
"assets/assets/icons/Setting_alt_fill.svg": "13f04de49affcee876d7166bc2bfff99",
"assets/assets/icons/up_arrow.svg": "0ae1c1223d88bfe9dd1be2fb91e94167",
"assets/assets/icons/Add_round.svg": "98e24065c7038653837f8387568b65e6",
"assets/assets/icons/Img_box_fill.svg": "6ce95501a5c407c40e79fbda27f0dda3",
"assets/assets/icons/Expand_left.svg": "68d0aed28c39b9bb31dd175c8ccaa3d0",
"assets/assets/icons/Arhive_load_fill.svg": "418a20ec5d246acb83eea60c05fef4c8",
"assets/assets/icons/home_bg.svg": "081626acc36e96b75d8ec272f662e352",
"assets/assets/icons/Add_round_fill.svg": "e0e7124139f69a91218f3403d45c6660",
"assets/assets/icons/circle_bg.svg": "fe07a6e5a77171f29cd02b666ba3b779",
"assets/assets/profile.png": "9e133f5818e0ed29e82945716095b878",
"assets/assets/gallery%2520img%25204.png": "d9852c4a5170612dae88a9999833d2c3"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
