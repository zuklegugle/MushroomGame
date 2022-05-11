extends Node

# player actions
signal action_started(player, action_name)
signal action_canceled(player, action_name)
signal action_performed(player, action_name)

# player interactions
signal interacted(interaction)

# player inventory
signal item_equipped(player, inventory, item)
