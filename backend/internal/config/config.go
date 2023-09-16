package config

import "github.com/pkg/errors"

type Config struct{}

func LoadFromEnv() (*Config, error) {
	return nil, errors.Errorf("not implemented yet")
}
