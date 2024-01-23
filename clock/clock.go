package clock

import (
	"time"
)

type Clocker interface {
	Now() time.Time
}

type RealClocker struct{}

func (r RealClocker) Now() time.Time {
	return time.Now()
}

type FixedClocker struct{}

func (f FixedClocker) Now() time.Time {
	return time.Date(2024, time.January, 1, 0, 0, 0, 0, time.UTC)
}
