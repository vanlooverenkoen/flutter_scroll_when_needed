# scroll_when_needed

[![Pub](https://img.shields.io/pub/v/scroll_when_needed.svg)](https://pub.dartlang.org/packages/scroll_when_needed)

This packages contains a custom scrollbehavior and scroll physics that can be used to have platform specific scrolling behaviour when there is not enough space in a scrollable widget

How to use this package:
```
ScrollConfiguration(
    behavior: ScrollWhenNeededBehavior(),
    child: ListView(
        physics: ScrollWhenNeededPhysics(targetPlatform: Theme.of(context).platform),
        children: [
            Container(
                height: 100,
                color: Colors.amber,
            ),
            TextField(),
            Container(
                height: 300,
                color: Colors.amber,
            ),
        ],
    ),
),
```