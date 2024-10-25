---
title: "Change Syntax highlighting Jekyll"
date: "2019-03-01 10:35"
comments_id: 	14
---

Jekyll use `.highlight` element in css to highlight syntax.
This can be overwritten in your assets/main.scss.

You can then easily use [pygments css](https://github.com/idleberg/base16-pygments/tree/master/css), modify it a bit to fit to the css code below and all is fine.

It should look like approximately like this:

```css
.highlight {
  background: #282828;
	 color: #ebdbb2;
	 background-color: #282828;
  @extend %vertical-rhythm;

  .highlighter-rouge & {
     background: #282828; color: #ebdbb2; background-color: #282828;
  }

  .hll { background-color: #ffffcc }
  .c { color: #928374; font-style: italic; background-color: #282828 } /* Comment */
  .err { color: #ebdbb2; background-color: #282828 } /* Error */
  .esc { color: #ebdbb2; background-color: #282828 } /* Escape */
  .g { color: #ebdbb2; background-color: #282828 } /* Generic */
  .k { color: #fe8019; background-color: #282828 } /* Keyword */
  .l { color: #ebdbb2; background-color: #282828 } /* Literal */
  .n { color: #ebdbb2; background-color: #282828 } /* Name */
  .o { color: #fe8019; background-color: #282828 } /* Operator */
  .x { color: #ebdbb2; background-color: #282828 } /* Other */
  .p { color: #ebdbb2; background-color: #282828 } /* Punctuation */
  .ch { color: #928374; font-style: italic; background-color: #282828 } /* Comment.Hashbang */
  .cm { color: #928374; font-style: italic; background-color: #282828 } /* Comment.Multiline */
  .cp { color: #8ec07c; background-color: #282828 } /* Comment.Preproc */
  .c1 { color: #928374; font-style: italic; background-color: #282828 } /* Comment.Single */
  .cs { color: #928374; font-style: italic; background-color: #282828 } /* Comment.Special */
  .gd { color: #282828; background-color: #fb4934 } /* Generic.Deleted */
  .ge { color: #83a598; text-decoration: underline; background-color: #282828 } /* Generic.Emph */
  .gr { color: #ebdbb2; font-weight: bold; background-color: #fb4934 } /* Generic.Error */
  .gh { color: #b8bb26; font-weight: bold; background-color: #282828 } /* Generic.Heading */
  .gi { color: #282828; background-color: #b8bb26 } /* Generic.Inserted */
  .go { color: #504945; background-color: #282828 } /* Generic.Output */
  .gp { color: #ebdbb2; background-color: #282828 } /* Generic.Prompt */
  .gs { color: #ebdbb2; background-color: #282828 } /* Generic.Strong */
  .gu { color: #b8bb26; font-weight: bold; background-color: #282828 } /* Generic.Subheading */
  .gt { color: #ebdbb2; font-weight: bold; background-color: #fb4934 } /* Generic.Traceback */
  .kc { color: #fe8019; background-color: #282828 } /* Keyword.Constant */
  .kd { color: #fe8019; background-color: #282828 } /* Keyword.Declaration */
  .kn { color: #fe8019; background-color: #282828 } /* Keyword.Namespace */
  .kp { color: #fe8019; background-color: #282828 } /* Keyword.Pseudo */
  .kr { color: #fe8019; background-color: #282828 } /* Keyword.Reserved */
  .kt { color: #fabd2f; background-color: #282828 } /* Keyword.Type */
  .ld { color: #ebdbb2; background-color: #282828 } /* Literal.Date */
  .m { color: #d3869b; background-color: #282828 } /* Literal.Number */
  .s { color: #b8bb26; background-color: #282828 } /* Literal.String */
  .na { color: #b8bb26; font-weight: bold; background-color: #282828 } /* Name.Attribute */
  .nb { color: #fabd2f; background-color: #282828 } /* Name.Builtin */
  .nc { color: #ebdbb2; background-color: #282828 } /* Name.Class */
  .no { color: #d3869b; background-color: #282828 } /* Name.Constant */
  .nd { color: #ebdbb2; background-color: #282828 } /* Name.Decorator */
  .ni { color: #fabd2f; background-color: #282828 } /* Name.Entity */
  .ne { color: #fb4934; background-color: #282828 } /* Name.Exception */
  .nf { color: #fabd2f; background-color: #282828 } /* Name.Function */
  .nl { color: #fb4934; background-color: #282828 } /* Name.Label */
  .nn { color: #ebdbb2; background-color: #282828 } /* Name.Namespace */
  .nx { color: #ebdbb2; background-color: #282828 } /* Name.Other */
  .py { color: #ebdbb2; background-color: #282828 } /* Name.Property */
  .nt { color: #fb4934; background-color: #282828 } /* Name.Tag */
  .nv { color: #ebdbb2; background-color: #282828 } /* Name.Variable */
  .ow { color: #fe8019; background-color: #282828 } /* Operator.Word */
  .w { color: #ebdbb2; background-color: #282828 } /* Text.Whitespace */
  .mb { color: #d3869b; background-color: #282828 } /* Literal.Number.Bin */
  .mf { color: #d3869b; background-color: #282828 } /* Literal.Number.Float */
  .mh { color: #d3869b; background-color: #282828 } /* Literal.Number.Hex */
  .mi { color: #d3869b; background-color: #282828 } /* Literal.Number.Integer */
  .mo { color: #d3869b; background-color: #282828 } /* Literal.Number.Oct */
  .sb { color: #b8bb26; background-color: #282828 } /* Literal.String.Backtick */
  .sc { color: #b8bb26; background-color: #282828 } /* Literal.String.Char */
  .sd { color: #b8bb26; background-color: #282828 } /* Literal.String.Doc */
  .s2 { color: #b8bb26; background-color: #282828 } /* Literal.String.Double */
  .se { color: #b8bb26; background-color: #282828 } /* Literal.String.Escape */
  .sh { color: #b8bb26; background-color: #282828 } /* Literal.String.Heredoc */
  .si { color: #b8bb26; background-color: #282828 } /* Literal.String.Interpol */
  .sx { color: #b8bb26; background-color: #282828 } /* Literal.String.Other */
  .sr { color: #b8bb26; background-color: #282828 } /* Literal.String.Regex */
  .s1 { color: #b8bb26; background-color: #282828 } /* Literal.String.Single */
  .ss { color: #83a598; background-color: #282828 } /* Literal.String.Symbol */
  .bp { color: #fabd2f; background-color: #282828 } /* Name.Builtin.Pseudo */
  .vc { color: #ebdbb2; background-color: #282828 } /* Name.Variable.Class */
  .vg { color: #ebdbb2; background-color: #282828 } /* Name.Variable.Global */
  .vi { color: #ebdbb2; background-color: #282828 } /* Name.Variable.Instance */
  .il { color: #d3869b; background-color: #282828 } /* Literal.Number.Integer.Long */
}

```

I am using here a background color. I add few troubles to find out how to solve this :

![Picture](https://dgrv.github.io/dorian-gravier/assets/images/20190301_css_code.jpg)

I add to overwrite few styles from the `code` and `pre` element. I also wanted to wrap the code (`white-space: pre-wrap; `)

```css
code {
 border: 0px solid #e8e8e8;
 background-color: #282828; // import for the background of the code, even with highlighting
 white-space: pre-wrap; // wrap the code
}

pre {
 border: 0px solid #e8e8e8;
}
```

Hopefully you is helping you :)
