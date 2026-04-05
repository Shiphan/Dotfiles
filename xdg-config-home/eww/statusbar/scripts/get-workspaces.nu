#!/usr/bin/env nu

mut info = do {
	let workspaces = hyprctl workspaces -j
		| from json
		| select id name
		| sort-by id
	let monitor = (hyprctl monitors -j | from json | get 0)

	{
		active_id: $monitor.activeWorkspace.id,
		active_special_id: $monitor.specialWorkspace.id,
		workspaces: ($workspaces | where id > 0),
		special_workspaces: ($workspaces | where id < 0),
	}
}

$info | to json --raw | print

for line in (socat -U - $"UNIX-CONNECT:($env.XDG_RUNTIME_DIR)/hypr/($env.HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock" | lines) {
	if $line starts-with "workspacev2>>" {
		$info.active_id = $line
			| str replace --regex "^workspacev2>>" ""
			| split row -n 2 -r ','
			| get 0
			| into int
	} else if $line starts-with "activespecialv2>>,," {
		$info.active_special_id = null
	} else if $line starts-with "activespecialv2>>" {
		$info.active_special_id = $line
			| str replace --regex "^activespecialv2>>" ""
			| split row -n 3 -r ','
			| get 0
			| into int
	} else if $line starts-with "createworkspacev2>>" {
		let workspace  = $line
			| str replace --regex "^createworkspacev2>>" ""
			| split row -n 2 -r ','
		let id = $workspace | get 0 | into int
		let name = $workspace | get 1
		if $id > 0 {
			$info.workspaces = $info.workspaces
				| append { id: $id, name: $name }
				| sort-by id
		} else if $id < 0 {
			$info.special_workspaces = $info.special_workspaces
				| append { id: $id, name: $name }
				| sort-by id
		}
	} else if $line starts-with "destroyworkspacev2>>" {
		let id = $line
			| str replace --regex "^destroyworkspacev2>>" ""
			| split row -n 2 -r ','
			| get 0
			| into int
		print $id
		if $id > 0 {
			$info.workspaces = $info.workspaces | where id != $id
		} else if $id < 0 {
			$info.special_workspaces = $info.special_workspaces | where id != $id
		}
	} else {
		continue
	}
	$info | to json --raw | print
}
