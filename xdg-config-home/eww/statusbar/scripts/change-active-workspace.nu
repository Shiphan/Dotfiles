#!/usr/bin/env nu

def clamp [min: int, max: int, x: int] {
	[([$x, $max] | math min), $min] | math max
}

def main [direction: string, current: int] {
	match $direction {
		"down" => {
			hyprctl dispatch workspace (clamp 1 10 ($current + 1))
		}
		"up" => {
			hyprctl dispatch workspace (clamp 1 10 ($current - 1))
		}
		_ => {
			print $"unknown direction: `($direction)`"
		}
	}
}
