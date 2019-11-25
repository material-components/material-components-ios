## Customization

### Positioning Action Sheet Actions

The layout of the Action Sheet list items can be adjusted with the
`contentEdgeInsets` API. Positive values will inset the content and negative
values will outset the conent. The insets apply to all action items.

<img src="docs/assets/actionsheet-default appearance.png" alt="Action Sheet showing three items with default edge content insets." width="375">
<!--{: .article__asset.article__asset--screenshot }-->
Action Sheet showing three items with default content insets.

For example, setting top and bottom insets (positive values) will reduce the
height of the Action list items. 

<img src="docs/assets/actionsheet-top and bottom insets.png" alt="Action Sheet showing three items with top and bottom content edge insets." width="375">
<!--{: .article__asset.article__asset--screenshot }-->
Action Sheet showing three items with top and bottom content edge insets.

Setting a left outset (negative value) and right inset (positive value) will
shift the Action's content to the trailing edge.

<img src="docs/assets/actionsheet-left outset right inset.png" alt="Action Sheet showing three items with a left content edge outset and right inset shifting content to the right." width="375">
<!--{: .article__asset.article__asset--screenshot }-->
Action Sheet showing three items with a left content edge outset and right inset shifting content to the right.
