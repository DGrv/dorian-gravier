---
layout: "post"
title: "Notepadd++ UserDefinedLang (theme) for Latex (tex) and Markdown (md) files"
date: "2019-06-09 12:32"
comments_id: 	29
---

I love Notepadd++ and I only use certainly 5% of its potential.
I like dark theme when I work on the computer and [Dracula theme](https://draculatheme.com/notepad-plus-plus/) is a pretty nice one.

I work a lot with markdown files (.md or .markdown)and this theme does not have this language so I add to create a *User defined language* (UserDefinedLang.xml) that is passing with Dracula.

Same for LaTex files (.tex)

Just put those 2 codes in a xml files in your /userDefineLangs folder.
You will also find those files here :

- [Markdown xml](/files/Notepad/UserDefined/Md_dracula.xml)
- [LaTex xml](/files/Notepad/UserDefined/NuTeX_dracula.xml)

# Markdown

```xml
<NotepadPlus>
    <UserLang name="Md Drakula" ext="md markdown" udlVersion="2.1">
        <Settings>
            <Global caseIgnored="no" allowFoldOfComments="no" foldCompact="no" forcePureLC="2" decimalSeparator="0" />
            <Prefix Keywords1="yes" Keywords2="yes" Keywords3="yes" Keywords4="yes" Keywords5="yes" Keywords6="yes" Keywords7="yes" Keywords8="no" />
        </Settings>
        <KeywordLists>
            <Keywords name="Comments">00# 01 02((EOL)) 03&lt;!-- 04--&gt;</Keywords>
            <Keywords name="Numbers, prefix1"></Keywords>
            <Keywords name="Numbers, prefix2"></Keywords>
            <Keywords name="Numbers, extras1"></Keywords>
            <Keywords name="Numbers, extras2"></Keywords>
            <Keywords name="Numbers, suffix1">.</Keywords>
            <Keywords name="Numbers, suffix2"></Keywords>
            <Keywords name="Numbers, range"></Keywords>
            <Keywords name="Operators1">@ &lt; &gt; \\ \` \* \_ \{ \} \[ \] \( \) \# \+ \- \. \!</Keywords>
            <Keywords name="Operators2">* - +</Keywords>
            <Keywords name="Folders in code1, open"></Keywords>
            <Keywords name="Folders in code1, middle"></Keywords>
            <Keywords name="Folders in code1, close"></Keywords>
            <Keywords name="Folders in code2, open"></Keywords>
            <Keywords name="Folders in code2, middle"></Keywords>
            <Keywords name="Folders in code2, close"></Keywords>
            <Keywords name="Folders in comment, open"></Keywords>
            <Keywords name="Folders in comment, middle"></Keywords>
            <Keywords name="Folders in comment, close"></Keywords>
            <Keywords name="Keywords1">http:// (http:// https:// (https:// mailto: (mailto: ftp:// (ftp:// ftps:// (ftps:// (/ /</Keywords>
            <Keywords name="Keywords2">==== ----</Keywords>
            <Keywords name="Keywords3">*** ___</Keywords>
            <Keywords name="Keywords4">** __</Keywords>
            <Keywords name="Keywords5">* _</Keywords>
            <Keywords name="Keywords6">** __</Keywords>
            <Keywords name="Keywords7">* _</Keywords>
            <Keywords name="Keywords8"></Keywords>
            <Keywords name="Delimiters">00![ 00[ 01\ 02] 02] 03` 04\ 05` 06*** 07\ 08*** 09** 10\ 11** 12* 13\ 14* 15** 16\ 17** 18* 19\ 20* 21 22 23</Keywords>
        </KeywordLists>
        <Styles>
            <WordsStyle name="DEFAULT" fgColor="F8F8F2" bgColor="282A36" fontName="" fontStyle="0" nesting="0" />
            <WordsStyle name="COMMENTS" fgColor="7F9F7F" bgColor="282A36" fontName="" fontStyle="2" nesting="0" />
            <WordsStyle name="LINE COMMENTS" fgColor="50FA7B" bgColor="282A36" fontName="" fontStyle="1" nesting="0" />
            <WordsStyle name="NUMBERS" fgColor="8CD0D3" bgColor="282A36" fontName="" fontStyle="0" nesting="0" />
            <WordsStyle name="KEYWORDS1" fgColor="EDD6ED" bgColor="282A36" fontName="" fontStyle="0" nesting="0" />
            <WordsStyle name="KEYWORDS2" fgColor="50FA7B" bgColor="282A36" fontName="" fontStyle="1" nesting="0" />
            <WordsStyle name="KEYWORDS3" fgColor="FF79C6" bgColor="282A36" fontName="" fontStyle="3" nesting="0" />
            <WordsStyle name="KEYWORDS4" fgColor="FF79C6" bgColor="282A36" fontName="" fontStyle="1" nesting="0" />
            <WordsStyle name="KEYWORDS5" fgColor="FF79C6" bgColor="282A36" fontName="" fontStyle="2" nesting="0" />
            <WordsStyle name="KEYWORDS6" fgColor="FF79C6" bgColor="282A36" fontName="" fontStyle="3" nesting="0" />
            <WordsStyle name="KEYWORDS7" fgColor="FF79C6" bgColor="282A36" fontName="" fontStyle="3" nesting="0" />
            <WordsStyle name="KEYWORDS8" fgColor="F8F8F2" bgColor="282A36" fontName="" fontStyle="0" nesting="0" />
            <WordsStyle name="OPERATORS" fgColor="21ffff" bgColor="282A36" fontName="" fontStyle="1" nesting="0" />
            <WordsStyle name="FOLDER IN CODE1" fgColor="F8F8F2" bgColor="282A36" fontName="" fontStyle="0" nesting="0" />
            <WordsStyle name="FOLDER IN CODE2" fgColor="F8F8F2" bgColor="282A36" fontName="" fontStyle="0" nesting="0" />
            <WordsStyle name="FOLDER IN COMMENT" fgColor="F8F8F2" bgColor="282A36" fontName="" fontStyle="0" nesting="0" />
            <WordsStyle name="DELIMITERS1" fgColor="EDD6ED" bgColor="282A36" fontName="" fontStyle="2" nesting="0" />
            <WordsStyle name="DELIMITERS2" fgColor="CEDF99" bgColor="282A36" fontName="" fontStyle="0" nesting="0" />
            <WordsStyle name="DELIMITERS3" fgColor="FF79C6" bgColor="282A36" fontName="" fontStyle="3" nesting="0" />
            <WordsStyle name="DELIMITERS4" fgColor="FF79C6" bgColor="282A36" fontName="" fontStyle="1" nesting="65600" />
            <WordsStyle name="DELIMITERS5" fgColor="FF79C6" bgColor="282A36" fontName="" fontStyle="2" nesting="32800" />
            <WordsStyle name="DELIMITERS6" fgColor="FF79C6" bgColor="282A36" fontName="" fontStyle="3" nesting="0" />
            <WordsStyle name="DELIMITERS7" fgColor="FF79C6" bgColor="282A36" fontName="300" fontStyle="3" nesting="0" />
            <WordsStyle name="DELIMITERS8" fgColor="F8F8F2" bgColor="282A36" fontName="3" fontStyle="0" nesting="0" />
        </Styles>
    </UserLang>
</NotepadPlus>

```

# LaTex

```xml
<NotepadPlus>
    <UserLang name="NuTex_dracula" ext="tex" udlVersion="2.1">
        <Settings>
            <Global caseIgnored="no" allowFoldOfComments="no" foldCompact="no" forcePureLC="0" decimalSeparator="2" />
            <Prefix Keywords1="no" Keywords2="no" Keywords3="no" Keywords4="no" Keywords5="no" Keywords6="no" Keywords7="no" Keywords8="yes" />
        </Settings>
        <KeywordLists>
            <Keywords name="Comments">00% 01 02 03 04</Keywords>
            <Keywords name="Numbers, prefix1">*</Keywords>
            <Keywords name="Numbers, prefix2">&#x2020;</Keywords>
            <Keywords name="Numbers, extras1">(</Keywords>
            <Keywords name="Numbers, extras2">)</Keywords>
            <Keywords name="Numbers, suffix1"></Keywords>
            <Keywords name="Numbers, suffix2"></Keywords>
            <Keywords name="Numbers, range"></Keywords>
            <Keywords name="Operators1">[ ] ( ) { } + - = / &lt; &gt;</Keywords>
            <Keywords name="Operators2">~ &amp; _ ^ |</Keywords>
            <Keywords name="Folders in code1, open"></Keywords>
            <Keywords name="Folders in code1, middle"></Keywords>
            <Keywords name="Folders in code1, close"></Keywords>
            <Keywords name="Folders in code2, open"></Keywords>
            <Keywords name="Folders in code2, middle"></Keywords>
            <Keywords name="Folders in code2, close"></Keywords>
            <Keywords name="Folders in comment, open">\section</Keywords>
            <Keywords name="Folders in comment, middle"></Keywords>
            <Keywords name="Folders in comment, close">\endsection</Keywords>
            <Keywords name="Keywords1"></Keywords>
            <Keywords name="Keywords2"></Keywords>
            <Keywords name="Keywords3"></Keywords>
            <Keywords name="Keywords4">todo todo: \todo</Keywords>
            <Keywords name="Keywords5">%</Keywords>
            <Keywords name="Keywords6">@</Keywords>
            <Keywords name="Keywords7"></Keywords>
            <Keywords name="Keywords8">\</Keywords>
            <Keywords name="Delimiters"></Keywords>
        </KeywordLists>
        <Styles>
            <WordsStyle name="DEFAULT" fgColor="FFFFFF" bgColor="282A36" fontName="" fontStyle="0" nesting="0" />
            <WordsStyle name="COMMENTS" fgColor="50FA7B" bgColor="282A36" fontName="" fontStyle="0" nesting="0" />
            <WordsStyle name="LINE COMMENTS" fgColor="50FA7B" bgColor="282A36" fontName="" fontStyle="0" nesting="117456000" />
            <WordsStyle name="NUMBERS" fgColor="8CD0D3" bgColor="282A36" fontName="" fontStyle="0" nesting="0" />
            <WordsStyle name="KEYWORDS1" fgColor="FF0000" bgColor="282A36" fontName="" fontStyle="0" nesting="0" />
            <WordsStyle name="KEYWORDS2" fgColor="FF8040" bgColor="282A36" fontName="" fontStyle="1" nesting="0" />
            <WordsStyle name="KEYWORDS3" fgColor="21FFFF" bgColor="282A36" fontName="" fontStyle="1" nesting="0" />
            <WordsStyle name="KEYWORDS4" fgColor="FF0000" bgColor="282A36" fontName="" fontStyle="5" fontSize="12" nesting="0" />
            <WordsStyle name="KEYWORDS5" fgColor="FFFFFF" bgColor="282A36" fontName="" fontStyle="0" nesting="0" />
            <WordsStyle name="KEYWORDS6" fgColor="FFFFFF" bgColor="282A36" fontName="" fontStyle="0" nesting="0" />
            <WordsStyle name="KEYWORDS7" fgColor="FFFFFF" bgColor="282A36" fontName="" fontStyle="0" nesting="0" />
            <WordsStyle name="KEYWORDS8" fgColor="FF79C6" bgColor="282A36" fontName="" fontStyle="0" nesting="0" />
            <WordsStyle name="OPERATORS" fgColor="1bd3d3" bgColor="282A36" fontName="" fontStyle="0" nesting="0" />
            <WordsStyle name="FOLDER IN CODE1" fgColor="FFFFFF" bgColor="282A36" fontName="" fontStyle="1" nesting="0" />
            <WordsStyle name="FOLDER IN CODE2" fgColor="FFFFFF" bgColor="282A36" fontName="" fontStyle="0" nesting="0" />
            <WordsStyle name="FOLDER IN COMMENT" fgColor="FFFFFF" bgColor="282A36" fontName="" fontStyle="1" nesting="0" />
            <WordsStyle name="DELIMITERS1" fgColor="FFFFFF" bgColor="282A36" fontName="" fontStyle="0" nesting="117443585" />
            <WordsStyle name="DELIMITERS2" fgColor="FFFFFF" bgColor="282A36" fontName="" fontStyle="1" nesting="117447681" />
            <WordsStyle name="DELIMITERS3" fgColor="FFFFFF" bgColor="282A36" fontName="" fontStyle="0" nesting="117575425" />
            <WordsStyle name="DELIMITERS4" fgColor="FFFFFF" bgColor="282A36" fontName="" fontStyle="0" nesting="117575425" />
            <WordsStyle name="DELIMITERS5" fgColor="FFFFFF" bgColor="282A36" fontName="" fontStyle="0" nesting="3072" />
            <WordsStyle name="DELIMITERS6" fgColor="FFFFFF" bgColor="282A36" fontName="" fontStyle="0" nesting="0" />
            <WordsStyle name="DELIMITERS7" fgColor="FFFFFF" bgColor="282A36" fontName="" fontStyle="0" nesting="0" />
            <WordsStyle name="DELIMITERS8" fgColor="FFFFFF" bgColor="282A36" fontName="" fontStyle="0" nesting="117576576" />
        </Styles>
    </UserLang>
</NotepadPlus>

```
