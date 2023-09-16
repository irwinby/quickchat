package app

import (
	"context"

	"github.com/pkg/errors"
	"go.uber.org/zap"

	"github.com/irwinby/quickchat/internal/config"
)

func Run(ctx context.Context, logger *zap.Logger) error {
	cfg, err := config.LoadFromEnv()
	if err != nil {
		return errors.Wrap(err, "load config environment variables")
	}

	return RunWithConfig(ctx, cfg, logger)
}

func RunWithConfig(_ context.Context, _ *config.Config, _ *zap.Logger) error {
	return errors.Errorf("not implemented yet")
}
