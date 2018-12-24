---
show_in_nav: false
layout: home
<ul>
{% for p in pages %}
    {% unless show_in_nav == false %}
    <li><a href="{{ site.baseurl }}{{ p.url }}">{{ p.title }}</a></li>
    {% endunless %}
{% endfor %}
</ul>
{: .-three-column}
---



Hi, welcome to the 1st draft of my website, where I wanna to be able to post a bit about me and my work as well as all the tips that I am discovering.
Trying to use the power of jekyll, especiall for the blog post. For the moment, it is great :)