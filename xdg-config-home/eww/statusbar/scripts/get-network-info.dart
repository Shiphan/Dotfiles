#!/usr/bin/env dart

import "dart:convert";
import "dart:io";

const device = "wlp1s0";

class Info {
	var enabled = false;
	var connected = false;
	var full = false;
	var name = "";
}

void main() async {
	var info = Info();

	await init(info);
	print_info(info);

	var result = await Process.start("nmcli", ["monitor"]);
	await result
		.stdout
		.transform(utf8.decoder)
		.transform(LineSplitter())
		.forEach((String line) => handleLine(info, line));
}

void handleLine(Info info, String line) {
	var updated = true;
	if (line.startsWith("$device: unavailable")) {
		info.enabled = false;
	} else if (line.startsWith("$device: ")) {
		info.enabled = true;
	} else if (line.startsWith("Connectivity is now 'full'")) {
		info.full = true;
	} else if (line.startsWith("Connectivity is now ")) {
		info.full = false;
	} else if (line.startsWith("Networkmanager is now in the 'connected' state")) {
		info.connected = true;
	} else if (line.endsWith(" is now the primary connection")) {
		final name_with_quote = line.replaceAll(" is now the primary connection", "");
		info.name = name_with_quote.substring(1, name_with_quote.length - 1);
	} else {
		updated = false;
	}
	if (updated) {
		print_info(info);
	}
}

void print_info(Info info) {
	print(jsonEncode({
		"enabled": info.enabled,
		"connected": info.connected,
		"full": info.full,
		"name": info.name,
	}));
}

Future<void> init(Info info) async {
	await (
		() async {
			info.enabled = ((await Process.run("nmcli", ["radio", "wifi"])).stdout as String).trim() == "enabled";
		}(),
		() async {
			switch (((await Process.run("nmcli", ["networking", "connectivity"])).stdout as String).trim()) {
				case "none":
					info.connected = false;
					info.full = false;
				case "full":
					info.connected = true;
					info.full = true;
				default:
					info.connected = true;
					info.full = false;
			}
		}(),
		() async {
			info.name = ((await Process.run("nmcli", ["--get-values", "GENERAL.CONNECTION", "device", "show", device])).stdout as String).trim();
		}(),
	).wait;
}
