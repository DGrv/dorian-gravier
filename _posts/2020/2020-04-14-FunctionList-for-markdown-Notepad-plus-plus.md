---
layout: "post"
title: "Use the function list menu with Notepad++ with markdown"
date: "2020-04-14 12:00"
comments_id: 38
---

I always wanted to have a way to go rapidly through the structure of long markdown files in Notepad++. 
Because this is a great little, simple, fast software. Exactly just what you need without being fancy when you need to do simple things.

I found a [post](https://community.notepad-plus-plus.org/topic/18458/display-markdown-outline-view-through-functionlist) in the forum of Notepad++ that to be able to do this using the Functioin List.

Several issue were also opened on Github where I replied : 

- [In functionList.xml association with extension does not work.
#5986](https://github.com/notepad-plus-plus/notepad-plus-plus/issues/5986)
- [functionList.xml for markdown files
#5945](https://github.com/notepad-plus-plus/notepad-plus-plus/issues/5945)

I copy my post here:

I could make it work for me with helped of post in the [Forum of Notepad++](https://community.notepad-plus-plus.org/topic/18458/display-markdown-outline-view-through-functionlist).

You have to modify your functionList.xml:
- associationMap part
  - it is important that your userDefinedLangName fit to the language used when your open your extension
- parser part
  - I modifiied the main expression in order to have before the # tag possibility to have 1 or several tabs (`|\t{1,5}`), because this is my way to structure my markdown file for lisibility : `"(?x)((?:^|\n|\t{1,5})[#]+\s+(.*?)(\r*|\n*)$)"`

Here what I mean regarding the tabs in my files
![Picture2](/assets/blog/20200414_functionList_markdown_2.jpg)
![Picture2](/assets/blog/20200414_functionList_markdown_3.jpg)


```xml
<associationMap>
	<association id=    "markdown_header"        userDefinedLangName="Md Drakula"           />
	<association id=    "markdown_header"        ext=".md"                                />
</associationMap>
```

```xml
<parsers>
	<!-- ======================================================== [ Markdown ] -->
	<!-- Based on code modified from https://community.notepad-plus-plus.org/topic/18458/display-markdown-outline-view-through-functionlist/7 -->
	<parser 
		displayName="Md Drakula" 
		id="markdown_header"
		commentExpr="">
		<function
			mainExpr="(?x)((?:^|\n|\t{1,5})[#]+\s+(.*?)(\r*|\n*)$)">
		</function>
	</parser>
</parsers>
```

Here the result:

![Picture2](/assets/blog/20200414_functionList_markdown_1.jpg)

If someone knows how to use the `functionName` (example  below) to replace the \t with space in order that the hierarchy is more lisible in the function list it would be great. 

```xml
<functionName>
                        <nameExpr expr="(?:[#]+\s+)(.*)"/>
</functionName>
```


