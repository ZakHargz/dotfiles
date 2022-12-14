package config

import "fmt"

type configDemo struct {
	configApps
}

var _ Config = (*configDemo)(nil)

func (c *configDemo) Install() error {
	for _, app := range c.Apps {
		for _, p := range app.Paths {
			fmt.Printf("Replace %s -> %s\n", p.Internal, p.External)
		}
	}

	return nil
}

func (c *configDemo) Update() error {
	for _, app := range c.Apps {
		for _, p := range app.Paths {
			fmt.Printf("Replace %s -> %s\n", p.External, p.Internal)
		}
	}

	return nil
}

func (c *configDemo) Clean() error {
	unusedDirs, err := getUnusedDirs(c.Apps)
	if err != nil {
		return err
	}

	for dir := range unusedDirs {
		fmt.Printf("Remove %s\n", dir)
	}

	return nil
}

func (c *configDemo) Diff() error {
	return nil
}
