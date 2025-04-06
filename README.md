# Text Purifier

A super simple Mac application that filters out non-ASCII characters in given text with Regex.

**Mac OS compatibility**: 10.10+. ARM Macs needs to install Rosetta 2 (Mac OS will prompt to install if not) before use.

## How To Use

Paste the text to the input box (the one on the left) and the click the Purify button, you'll then get the text without non-ASCII characters in the output box (the one on the left).

It support multiple lines input. The Regex that filters characters is located at variable `validCharRegex` in `ViewController.swift`.