---
title: "Markdown语法"
permalink: /notes/overview/markdown-cheatsheet
---

## 标题

### 一级标题

    Markup :  # Heading 1 #

    -OR-

    Markup :  ============= (below H1 text)

### 二级标题

    Markup :  ## Heading 2 ##

    -OR-

    Markup: --------------- (below H2 text)

### 三级标题

    Markup :  ### Heading 3 ###

### 四级标题

    Markup :  #### Heading 4 ####

## 格式
### 正文

    Markup :  Common text

### _斜体_

    Markup :  _Emphasized text_ or *Emphasized text*

### ~~删除线~~

    Markup :  ~~Strikethrough text~~

### __加粗__

    Markup :  __Strong text__ or **Strong text**

### ___加粗斜体___

    Markup :  ___Strong emphasized text___ or ***Strong emphasized text***

### [超链接](http://www.google.fr/)

    Markup :  [Named Link](http://www.google.fr/)

### [文内超链接](#一级标题 "Goto heading-1")

    [文内超链接](#一级标题 "Goto heading-1")

### 图片

![picture alt](http://via.placeholder.com/200x150 "Title is optional")

    Markup : ![picture alt](http://via.placeholder.com/200x150 "Title is optional")

## 表格

### 表格, like this one :

First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | Content Cell

```
First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | Content Cell
```

Adding a pipe `|` in a cell :

First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | \|

```
First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  |  \| 
```

### 表格中的对齐方式

Left aligned Header | Right aligned Header | Center aligned Header
| :--- | ---: | :---:
Content Cell  | Content Cell | Content Cell
Content Cell  | Content Cell | Content Cell

```
Left aligned Header | Right aligned Header | Center aligned Header
| :--- | ---: | :---:
Content Cell  | Content Cell | Content Cell
Content Cell  | Content Cell | Content Cell
```

## 代码

### 行内代码

`code()`

    Markup :  `code()`

### 块代码

```javascript
var specificLanguage_code = 
{
    "data": {
        "lookedUpPlatform": 1,
        "query": "Kasabian+Test+Transmission",
        "lookedUpItem": {
            "name": "Test Transmission",
            "artist": "Kasabian",
            "album": "Kasabian",
            "picture": null,
            "link": "http://open.spotify.com/track/5jhJur5n4fasblLSCOcrTp"
        }
    }
}
```

    Markup : ```javascript
             ```

## 列表

### 无序列表

* Bullet list
    * Nested bullet
        * Sub-nested bullet etc
* Bullet list item 2

~~~
 Markup : * Bullet list
              * Nested bullet
                  * Sub-nested bullet etc
          * Bullet list item 2

-OR-

 Markup : - Bullet list
              - Nested bullet
                  - Sub-nested bullet etc
          - Bullet list item 2 
~~~

### 有序列表

1. A numbered list
    1. A nested numbered list
    2. Which is numbered
2. Which is numbered

~~~
 Markup : 1. A numbered list
              1. A nested numbered list
              2. Which is numbered
          2. Which is numbered
~~~

### 待办列表

- [ ] An uncompleted task
- [x] A completed task

~~~
 Markup : - [ ] An uncompleted task
          - [x] A completed task
~~~

- [ ] An uncompleted task
    - [ ] A subtask

~~~
 Markup : - [ ] An uncompleted task
              - [ ] A subtask
~~~

## 引用

> Blockquote
>> Nested blockquote

    Markup :  > Blockquote
              >> Nested Blockquote

## 分割线
_Horizontal line :_
- - - -

    Markup :  - - - -



## 折叠文本

<details>
  <summary>Title 1</summary>
  <p>Content 1 Content 1 Content 1 Content 1 Content 1</p>
</details>
<details>
  <summary>Title 2</summary>
  <p>Content 2 Content 2 Content 2 Content 2 Content 2</p>
</details>

    Markup : <details>
               <summary>Title 1</summary>
               <p>Content 1 Content 1 Content 1 Content 1 Content 1</p>
             </details>

## [Go To TOP](#TOP)

    Markup : [Go To TOP](#TOP)

## Hotkey:

<kbd>⌘F</kbd>

<kbd>⇧⌘F</kbd>

    Markup : <kbd>⌘F</kbd>

Hotkey list:

| Key | Symbol |
| --- | --- |
| Option | ⌥ |
| Control | ⌃ |
| Command | ⌘ |
| Shift | ⇧ |
| Caps Lock | ⇪ |
| Tab | ⇥ |
| Esc | ⎋ |
| Power | ⌽ |
| Return | ↩ |
| Delete | ⌫ |
| Up | ↑ |
| Down | ↓ |
| Left | ← |
| Right | → |

## Emoji:

:exclamation: Use emoji icons to enhance text. :+1:  Look up emoji codes at [emoji-cheat-sheet.com](http://emoji-cheat-sheet.com/)

    Markup : Code appears between colons :EMOJICODE:
