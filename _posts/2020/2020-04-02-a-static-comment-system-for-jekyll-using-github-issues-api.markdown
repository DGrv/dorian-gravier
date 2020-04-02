---
layout: "post"
title: "A static comment system for Jekyll using Github Issues API"
date: "2020-04-02 16:44"
comments_id: 35
---

I looked few times for such solution and found a pretty satisfying one and easy to install on a github page.
All the comment will stay on your website and you will still have access to it since they are coming from comments in your repository via Issues.

All the information present here come from [aristaht blog post](https://aristath.github.io/blog/static-site-comments-using-github-issues-api). What I am describing here is only how I install it and modified few things to make it work how I wanted.

What you need to understand is that :
- comments are coming from replies in an issue of your repository
- a post is linked to an issue via a tag `comments_id: 3` in your [Jekyll Front matter](https://jekyllrb.com/docs/front-matter/). Here this is issue number 3 (#3)
- you will have to modify or create few files
  - you will have to have a `_includes/comments.html` (code below)
  - insert the comments in your layout by creating `_layouts/post.html`  (code below)
  - modify your scss if needed in `assets/main.scss`, or create a new on (I am actually not sure how this is working)
- [Github Issue API](https://developer.github.com/v3/issues/) will get the comments, information about the user, avatar and so on
- [showdown.js](https://github.com/showdownjs/showdown) will render all of this by its own


# _includes/comments.html

```html

<script src="  https://unpkg.com/showdown/dist/showdown.min.js"></script>
<script>
const GH_API_URL = 'https://api.github.com/repos/DGrv/dorian.gravier.github.io/issues/{{ page.comments_id }}/comments' //?client_id={{ site.data.settings.gh_api.ci }}&client_secret={{ site.data.settings.gh_api.cs }}';
// To use this follow instruction in https://aristath.github.io/blog/static-site-comments-using-github-issues-api
// the gh_api key where place in the settings.yml of this website : https://github.com/aristath/aristath.github.com/blob/f1b80c1202ed9edd3d5b8b9ba7cf15f347d4bfc6/_data/settings.yml

let request = new XMLHttpRequest();
request.open( 'GET', GH_API_URL, true );
request.onload = function() {
	if ( this.status >= 200 && this.status < 400 ) {
		let response = JSON.parse( this.response );

		for ( var i = 0; i < response.length; i++ ) {
			document.getElementById( 'gh-comments-list' ).appendChild( createCommentEl( response[ i ] ) );
		}

		if ( 0 === response.length ) {
			document.getElementById( 'no-comments-found' ).style.display = 'block';
		}
	} else {
		console.error( this );
	}
};

function createCommentEl( response ) {
	let user = document.createElement( 'a' );
	user.setAttribute( 'href', response.user.url );
	user.classList.add( 'user' );

	let userAvatar = document.createElement( 'img' );
	userAvatar.classList.add( 'avatar' );
	userAvatar.setAttribute( 'src', response.user.avatar_url );

	user.appendChild( userAvatar );

	let commentLink = document.createElement( 'a' );
	commentLink.setAttribute( 'href', response.html_url );
	commentLink.classList.add( 'comment-url' );
	commentLink.innerHTML = '#' + response.id + ' - ' + response.created_at;

	let commentContents = document.createElement( 'div' );
	commentContents.classList.add( 'comment-content' );
	commentContents.innerHTML = response.body;

	let comment = document.createElement( 'li' );
	comment.setAttribute( 'data-created', response.created_at );
	comment.setAttribute( 'data-author-avatar', response.user.avatar_url );
	comment.setAttribute( 'data-user-url', response.user.url );

	comment.appendChild( user );
	comment.appendChild( commentContents );
	comment.appendChild( commentLink );

	return comment;
}
request.send();
</script>


<hr>

<div class="github-comments">
	<br>
	<h2>Comments</h2>
	<ul id="gh-comments-list"></ul>
	<p id="leave-a-comment">Join the discussion for this article on <a href="https://github.com/DGrv/dorian.gravier.github.io/issues/{{ page.comments_id }}">this ticket</a>. Comments appear on this page instantly.
	<br>Thanks to <a href="https://aristath.github.io/blog/static-site-comments-using-github-issues-api">aristaht</a> for making this static comment system possible.</p>
</div>
```

# _layouts/post.html

```html
---
layout: default
---

<section class="intro">
	<div class="wrap">
		<h1>{{ page.title }}</h1>
		<p>{{ page.date | date_to_long_string }}</p>
	</div>
</section>

<section class="single">
	<div class="wrap">
		{{ page.content }}



		 <!-- To add the comments. Found on https://aristath.github.io/blog/static-site-comments-using-github-issues-api
			and https://github.com/aristath/aristath.github.com/blob/f1b80c1202ed9edd3d5b8b9ba7cf15f347d4bfc6/_layouts/post.html#L22-L24
			Need a comments.html in the _includes folder, an issue, take care of the id and a tag in the post (comment_id)-->
		{% if page.comments_id %}
			{% include comments.html %}
		{% endif %}




	</div>
</section>
```

# assets/main.scss

I added this part.

```css

#gh-comments-list {
    list-style: none;
    list-style-type: none;

    li {
        margin: 0;
        padding: 1.5em 0;
        display: flex;
        flex-wrap: wrap;
        border-top: 1px solid #aaa;

        >a.user {
            width: 200px;
            /* height: 200px; */
            overflow: hidden;
            padding: 3px;

            img {
                border-radius: 50%;
                /* border: 1px solid #fff; */
                /* box-shadow: 0 0 3px #aaa; */
            }
        }

        >a.comment-url {
            width: 100%;
            text-align: right;
            font-size: .6em;
            opacity: .5;

            &:hover {
                opacity: 1;
            }
        }

        .comment-content {
            padding: 0 1.5em;
        }
    }
}

#leave-a-comment {
    background: #504945;
    /* color: #fff; */
	border: 1px solid #fff;
    padding: 1rem;

    /* a { */
        /* color: #fff; */
        /* border-bottom-color: #fff; */
        /* outline-color: #fff; */
    /* } */
}

#no-comments-found {
    font-size: .8rem;
    display: none;
}

```

END OF THE POST

END OF THE POST

END OF THE POST

END OF THE POST
