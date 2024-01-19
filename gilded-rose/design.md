# Design

## Goal

The goal of this exercise is for the student to practice refactoring as a way to make existing code easier to change.

## Notes

The starting code and the tests are based on [Jim Weirich's version](https://github.com/jimweirich/gilded_rose_kata) of the Gilded Rose Kata.

The most notable change from the original is that the not-yet-implemented feature has been expanded. Here is that feature's description in the original:

> We have recently signed a supplier of conjured items. This requires an update to our system:
> - "Conjured" items degrade in Quality twice as fast as normal items

In the original, then, "conjured" is just another item category. An item can be *either* normal, *or* conjured, *or* Aged Brie, and so on.

But in this version, "conjured" is *not exclusive* to the existing categories. So there are *conjured normal items*, *conjured Aged Brie*, etc., each category getting a *different* effect from its conjured status.

The reason for this change is that the original exercise can be "solved" by adding just a few lines in two places, with no refactoring whatsoever. Ordinarily this isn't a problem, because most people who seek out the Gilded Rose Kata do so *because* it's a refactoring exercise. But originally I adapted this kata for [Exercism](https://exercism.org), where students may be tempted to take a shortcut that bypasses refactoring.

This version's more complex requirements are designed to discourage skipping the refactor, which now would mean adding code *throughout* the "update" method until it's twice its starting length. The painfulness of such an attempt will hopefully nudge the student to see that it is indeed a good idea to refactor first. Or in the words of Kent Beck, *"Make the change easy (warning: this may be hard), then make the easy change."*
