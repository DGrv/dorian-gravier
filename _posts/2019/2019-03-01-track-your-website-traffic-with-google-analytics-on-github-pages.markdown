---
title: "Track your website traffic with Google Analytics on github pages"
date: "2019-03-01 09:35"
comments_id: 	16
---

Simply go in Settings from your Google Analytics and create a new property.

Copy your Code ID in your header.html on your github pages.
E.g. I use minimal theme fopr github pages. I got the source code via the [minima repository](https://github.com/jekyll/minima/blob/master/_includes/header.html) (actually where you can also modify your navigation links - will be another post in future).
Place it in _includes/ in your repository (e.g.  _includes/header.html) and add your code ID between the header balise at the end.

```html

<header class="site-header">

<!--Here commented code, in order that you see the source. If I do not comment it Jekyll will build the correct header */ -->
<!--Here commented code, in order that you see the source. If I do not comment it Jekyll will build the correct header */ -->
<!--Here commented code, in order that you see the source. If I do not comment it Jekyll will build the correct header */ -->
<!--Here commented code, in order that you see the source. If I do not comment it Jekyll will build the correct header */ -->

  <!--<div class="wrapper">
    {%- assign default_paths = site.pages | map: "path" -%}
    {%- assign page_paths = site.header_pages | default: default_paths | sort: "order"-%}
    {%- assign titles_size = site.pages | map: 'title' | join: '' | size -%}
    <a class="site-title" rel="author" href="{{ "/" | relative_url }}">{{ site.title | escape }}</a>

    {%- if titles_size > 0 -%}
      <nav class="site-nav">
        <input type="checkbox" id="nav-trigger" class="nav-trigger" />
        <label for="nav-trigger">
          <span class="menu-icon">
            <svg viewBox="0 0 18 15" width="18px" height="15px">
              <path d="M18,1.484c0,0.82-0.665,1.484-1.484,1.484H1.484C0.665,2.969,0,2.304,0,1.484l0,0C0,0.665,0.665,0,1.484,0 h15.032C17.335,0,18,0.665,18,1.484L18,1.484z M18,7.516C18,8.335,17.335,9,16.516,9H1.484C0.665,9,0,8.335,0,7.516l0,0 c0-0.82,0.665-1.484,1.484-1.484h15.032C17.335,6.031,18,6.696,18,7.516L18,7.516z M18,13.516C18,14.335,17.335,15,16.516,15H1.484 C0.665,15,0,14.335,0,13.516l0,0c0-0.82,0.665-1.483,1.484-1.483h15.032C17.335,12.031,18,12.695,18,13.516L18,13.516z"/>
            </svg>
          </span>
        </label>

        <div class="trigger">
          {% assign navigation_pages = site.pages | sort: 'order' %}
          {% for p in navigation_pages %}
            {%- unless p.show_in_nav == false -%}
              {% if p.title %}
                <a class="page-link" href="{{ p.url | relative_url }}">{{ p.title | escape }}</a>
              {% endif %}
            {%- endunless -%}
          {% endfor %}
          <a class="page-link" href="leaflet.html"><img src="icon/loca.png" height="40" style="box-shadow: none;"></a>
        </div>
      </nav>
    {%- endif -%}
  </div>  -->

  <!-- Start of the Google Analytics code ID
   Start of the Google Analytics code ID
   Start of the Google Analytics code ID
   Start of the Google Analytics code ID
   Start of the Google Analytics code ID  -->
  <!-- Global site tag (gtag.js) - Google Analytics -->
  <script async src="https://www.googletagmanager.com/gtag/js?id=UA-12505632-3"></script>
  <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());

    gtag('config', 'UA-12505632-3');
  </script>
  <!--/* End of the Google Analytics code ID 
   End of the Google Analytics code ID
   End of the Google Analytics code ID
   End of the Google Analytics code ID
   End of the Google Analytics code ID  -->

</header>


```
