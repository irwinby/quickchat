package main

import (
	"context"

	"go.uber.org/zap"

	"github.com/irwinby/quickchat/internal/app"
)

func main() {
	ctx := context.Background()

	logger, _ := zap.NewProduction()

	err := app.Run(ctx, logger)
	if err != nil {
		logger.Fatal("run app", zap.Error(err))
	}
}
