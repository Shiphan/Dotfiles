package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"io"
	"os/exec"
	"time"
)

type Info struct {
	enabled   bool
	searching bool
	connected bool
}

func (info Info) print() {
	j, _ := json.Marshal(info)
	fmt.Println(string(j))
}

func main() {
	info := Info{false, false, false}
	var stdoutPipe io.ReadCloser
	var err error

	nice := false
	for !nice {
		nice = true

		// cmd := exec.Command("bluetoothctl")
		// cmd := exec.Command("bash", "-c", "a=$(bluetoothctl); for i in {1..10}; do echo a; sleep 1; done; sleep 10; echo b; echo \"abc\" | while read -r line; do echo a; done")
		cmd := exec.Command("bash", "/home/shiphan/.config/eww/statusbar/scripts/get-bluetooth-state/get-bluetooth-state.sh")
		// cmd := exec.Command("wtdwi")
		stdoutPipe, err = cmd.StdoutPipe()
		if err != nil {
			info.print()
			nice = false
		}

		err = cmd.Start()
		fmt.Println("cmd start")
		if err != nil {
			info.print()
			nice = false
		}

		if !nice {
			time.Sleep(2 * time.Second)
		}
	}

	scanner := bufio.NewScanner(stdoutPipe)

	i := 0
	for scanner.Scan() {
		fmt.Print(i)
		i++
		fmt.Println(scanner.Text())
	}
	fmt.Println("end")
}
