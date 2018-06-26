# List Items

Material Design Lists are a continuous group of text or images. The elements comprising Lists are referred to as List Items. The MDCBaseCell is a List Item at its simplest--a basic UICollectionViewCell subclass with Material Ink Ripple and Elevation.

## Description

The [Material guidelines](https://material.io/go/design-lists) for Lists are extensive, and there is no class at this time for implementing any one of them, let alone all of them. However, the MDCBaseCell provides a starting point to build anything the guidelines provide.

To build a List using the MDCBaseCell simply treat it like you would any other UICollectionViewCell.

The MDCBaseCell has two configurable properties--Ink Ripple color (`currentInkColor`) and Elevation (`elevation`).

Below is an example:

![MDCBaseCell Example](https://user-images.githubusercontent.com/8020010/42164205-3a7f699a-7dfd-11e8-9109-a7a6040996db.gif)
