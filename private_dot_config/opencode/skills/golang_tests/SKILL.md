---
name: golang-tests
description: Create consistently styled and organised tests in go
license: MIT
compatibility: opencode
---

## What I do

- Help write Go tests that match the preferred structure and style
- Recommend table-driven test layouts, shared resources, assertions, mocks, and
  test utilities
- Prioritize meaningful coverage for business rules, mappings, boundaries, and
  integration-style adapters

## When to use me

Use this when creating, updating, or reviewing Go tests, especially when you
want consistent table tests, deterministic test data, idiomatic helpers, gomock
usage, and coverage focused on behavior rather than line execution.

# Go Tests

## Style

### TableTests

Tests that all target one unit-test scope, e.g. a single function call, and
require similar setup steps, can be combined in the table-test format. I like to
write my tabletests along the following format:

```go
package golangtests

import "testing"

func TestSomething(t *testing.T) {
	t.Run("<to-test> should", func(t *testing.T) {
		// convenience resources

		// testcases
		testcases := []struct {
			desc   string
			setup_ any // e.g. a function that takes mocked dependencies and sets up mock expectations
			input_ any // one or more `input_<param>` for function input or a function that resolves and returns inputs
			exp_   any // e.g. `expectError bool` or `expectResponse *SomeResponseStruct`
		}{
			{
				desc: "",
			},
		}

		for _, tc := range testcases {
			t.Run(tc.desc, func(t *testing.T) {
				// setup test structs

				// setup test data

				// test

				// assert

			})
		}
	})
}
```

An example of a real tabletest according to this style:

```go
package batchtriggerconsumer

import (
	"math"
	"testing"
	"time"

	"bitbucket.org/inniuslabs/ml-batch-analyzer-backend/pkg/app/common"
	"bitbucket.org/inniuslabs/ml-batch-analyzer-backend/pkg/app/data/redis"
	"bitbucket.org/inniuslabs/ml-batch-analyzer-backend/pkg/app/domain"
	"bitbucket.org/inniuslabs/ml-batch-analyzer-backend/pkg/app/services/batch-trigger-consumer/mocks"
	u "bitbucket.org/inniuslabs/ml-batch-analyzer-backend/testing"
	"github.com/jonboulle/clockwork"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"go.uber.org/mock/gomock"
)

func TestAggregateSensor(t *testing.T) {
	t.Run("aggregator should", func(t *testing.T) {
		// convenience resources
		tm := u.MustTime(t, "2026-04-20 12:00")
		clock := clockwork.NewFakeClockAt(tm)
		mtrn, sid, bsid := "mach-123", "sen-123", "batch-sen-123"
		rate := 1
		aggregation := domain.AggregateAverage
		logger := u.Logger()
		s := time.Second

		// testcases
		testcases := []struct {
			desc          string
			setup         func(*sensorAggregator)
			input_periods []common.TimeFrame
			exp_err       bool
			exp_float     func(float64)
			exp_valid     bool
		}{
			{
				desc: "should return (NaN, false, nil) when no batch-periods are known",
				setup: func(s *sensorAggregator) {
					// mock info call
					// mock range for each period
					s.data.redis.(*mocks.MockRedisI).EXPECT().
						Info(gomock.Any(), redisSensor(mtrn, sid)).
						Return(&redis.KeyInfo{SensorRate: rate}, nil)
				},
				input_periods: []common.TimeFrame{},
				exp_err:       false,
				exp_float:     func(res float64) { require.True(t, math.IsNaN(res)) },
				exp_valid:     false,
			},
			{
				desc: "should return (<float64>, true, nil) when batch-periods are known and sensor-data is available",
				setup: func(agg *sensorAggregator) {
					// mock info call
					// mock range for each period
					agg.data.redis.(*mocks.MockRedisI).EXPECT().
						Info(gomock.Any(), redisSensor(mtrn, sid)).
						Return(&redis.KeyInfo{SensorRate: rate}, nil)
					agg.data.redis.(*mocks.MockRedisI).EXPECT().
						RangeWithPrevious(gomock.Any(), redisSensor(mtrn, sid), redis.Timerange{tm, tm.Add(10 * s)}, true, false).
						Return([]common.TimestampedValue{{Timestamp: tm, Value: 12}}, nil)
				},
				input_periods: []common.TimeFrame{{
					Start: tm,
					End:   tm.Add(10 * s),
				}},
				exp_err:   false,
				exp_float: func(res float64) { require.False(t, math.IsNaN(res)) },
				exp_valid: true,
			},
		}

		for _, tc := range testcases {
			t.Run(tc.desc, func(t *testing.T) {
				// setup test structs
				ctrl := gomock.NewController(t)
				redis := mocks.NewMockRedisI(ctrl)
				sut := sensorAggregator{
					log:   &logger,
					clock: clock,
					setup: &AggregationSetup{},
					batchSensor: common.Sensor{
						MachineTRN: mtrn,
						SensorID:   bsid,
					},
					data: &databases{
						redis: redis,
					},
				}

				// setup test data
				if tc.setup != nil {
					tc.setup(&sut)
				}

				// test
				res, valid, err := sut.aggregateSensor(
					domain.BatchSensor{SensorID: sid, Aggregation: aggregation},
					tc.input_periods,
				)

				// assert
				if tc.exp_err {
					assert.Error(t, err)
					return
				}

				require.NoError(t, err)
				require.EqualValues(t, tc.exp_valid, valid)
				if tc.exp_float != nil {
					tc.exp_float(res)
				}
			})
		}
	})
}
```

### TestUtils

My modern go projects often contain a `testing/utils.go`, `test/utils.go`,
`testing/testutils.go`, or `test/testutils.go` file. Always inspect this file
before writing tests and prefer its helpers over ad-hoc setup in the test file.

Import it with the short alias `u`, e.g.:

```go
import u "bitbucket.org/inniuslabs/ml-batch-analyzer-backend/testing"
```

Use this package for:

- `u.Logger()` when a subject under test needs a `slog.Logger`.
- `u.MustTime(t, "2026-04-20 12:00")` for fixed UTC timestamps.
- `u.MustToday(t, "12:00")` or `u.MustYesterday(t, "12:00")` when the test is
  intentionally relative to the current date.
- `u.UX(123)` when a Unix timestamp is clearer than a formatted timestamp.
- `u.UID()` when an arbitrary UUID is sufficient.
- `u.MachineTRN()` when a valid machine TRN is needed but its exact value is not
  part of the assertion.
- `u.LocalRedis()` and `u.LocalDynamo(...)` only for integration-style tests
  that intentionally depend on local services.

Prefer deterministic helpers. For example, use `u.MustTime` over `time.Now()`
when the exact date is not the thing being tested. Use `u.UID()` and
`u.MachineTRN()` for identifiers that only need to be valid and unique; use
plain constants like `"machine-123"`, `"sensor-123"`, or `"batch-123"` when
readability or exact expected output matters.

### Shared resources

Tests are often able to share or reuse resources. A good example is a timestamp.
Define shared resources once at the top of the outer `t.Run`, directly under the
`// convenience resources` comment, and then derive related values from them.

Consider a test that calls a query-function that takes parameters `startTime`
and `endTime` to apply to the query. In such cases I always define one reusable
variable `tm`, with time set to the current day at 12:00 UTC.

```go
tm := u.MustTime(t, "2026-04-20 12:00")
s := time.Second
start := tm
end := tm.Add(10 * s)
```

The same applies to IDs, domain constants, fake clocks, loggers, and other
inputs that several testcases share:

```go
tm := u.MustTime(t, "2026-04-20 12:00")
clock := clockwork.NewFakeClockAt(tm)
logger := u.Logger()
mtrn, sid, bsid := "mach-123", "sen-123", "batch-sen-123"
rate := 1
```

Prefer short, reusable names for shared resources: `tm` for the main timestamp,
`s` for `time.Second`, `ctx` for context, `mtrn` for machine TRN, `sid` for
sensor ID, and `sut` for the subject under test. Keep testcase-specific values
inside the testcase struct using `input_`, `exp_`, and `setup` fields.

Do not hide important test data in helper functions when inline shared resources
would make the test easier to read. The goal is that each testcase only contains
what changes for that case, while common facts remain visible above the table.

### Assertions

Prefer `require` for preconditions that must hold before the rest of the test
can safely continue, and `assert` for independent checks where seeing multiple
failures is useful.

Common pattern:

```go
res, err := sut.DoSomething(ctx, input)

if tc.exp_err {
	assert.Error(t, err)
	return
}

require.NoError(t, err)
assert.Equal(t, tc.exp_result, res)
```

Use `require.NoError` before dereferencing returned pointers or inspecting
returned structs. Use `assert.Contains(t, err.Error(), "...")` when the exact
error type is not important but the context in the wrapped error is.

For pure helper functions, it is also acceptable to use plain `t.Errorf` when
the assertion needs custom per-index messages, but new tests should generally
prefer `testify/assert` and `testify/require` for consistency.

### Mocks

Service tests usually use `go.uber.org/mock/gomock` with generated mocks in a
package-local `mocks` directory.

Abbreviate the `gomock` import to `gm`, e.g:

```go
import gm "go.uber.org/mock/gomock"
```

Create mocks inside each subtest so expectations cannot leak between cases.

```go
ctrl := gomock.NewController(t)
repo := mocks.NewMockRepository(ctrl)
sut := New(repo, logger)
```

When the setup is repeated across many tests, a small helper is fine:

```go
func newTestService(t *testing.T) (*Service, *mocks.MockRepository) {
	t.Helper()
	ctrl := gomock.NewController(t)
	repo := mocks.NewMockRepository(ctrl)
	return New(repo, slog.Default()), repo
}
```

Put testcase-specific expectations in the testcase `setup` function or directly
inside the subtest before the call under test. Prefer exact arguments for IDs,
timestamps, and domain structs that are important to the behavior. Use
`gomock.Any()` only for arguments that are genuinely irrelevant, such as a
context passed through unchanged.

Use `gomock.Cond` to only partially evaluate input parameters, in cases where
the input parameter is a (large) struct where most fields do not pertain to test
vailidity:

```go
sensorRepo.EXPECT().ListSensorsByMachine(gomock.Any(), "machine-1").Return([]domain.Sensor{
    {ID: "existing-0", Name: "existing_0"},
    {ID: "new-sensor", Name: "new_sensor"},
}, nil).Times(2)
configRepo.EXPECT().Update(gomock.Any(), gomock.Cond(func(c domain.BatchConfiguration) bool {
    return len(c.Sensors) == domain.MaxBatchSensorsPerConfig
})).Return(nil)
```

### Coverage priorities

When adding tests for coverage, prefer tests that protect business rules and
field mappings over tests that only execute lines. Consider the following
high-value targets:

- service entry points that orchestrate calls to repositories, models, or other
  services;
- security gates, authentication middleware, CSRF, rate-limit, and header logic;
- translation and mapping functions between ML, DynamoDB, Redis, HTTP, and
  domain types;
- publish/update paths where a regression could silently drop or overwrite data;
- boundary values for thresholds, limits, pagination, sorting, and truncation.

Good coverage tests should include success, missing-data, dependency-error, and
boundary cases. For example, when testing truncation, include exactly-at-limit,
one-over-limit, empty input, and nil input if the code accepts nil.

### Integration-style adapter tests

Tests that use `u.LocalDynamo()`, `u.LocalRedis()`, DynamoDB Local, Redis, or
real network/listener infrastructure are integration-style tests even if they
live in `*_test.go` files without a build tag. Keep them separate from pure
service unit tests where possible.

For adapter tests:

- use unique table names, keys, company IDs, config IDs, and sensor IDs;
- clean up or isolate data so one test run cannot affect another;
- prefer `u.MustTime` / `u.UX` for deterministic timestamps;
- assert both the stored representation and the domain representation when a
  mapper is part of the behavior;
- include not-found and empty-result cases, not only create/get happy paths.

Do not use local service helpers in unit tests that can be covered with mocks.

### Edge cases and boundaries

Add edge cases deliberately. The tests are strongest when they cover named
boundary behavior rather than only the common path.

Useful cases to consider:

- empty slices, nil slices, and single-element slices;
- unknown IDs, stale references, missing optional fields, and unknown enum
  values;
- exact threshold values, just below threshold, and just above threshold;
- exact string-length limits and one character over the limit;
- values containing separators such as `#` when testing composite keys;
- zero timestamps, Unix timestamps, and newest-vs-oldest sorting;
- empty maps, nil map values, and maps with one entry;
- HTMX and non-HTMX request variants for web handlers and middleware.

Name testcases by behavior, e.g. `"returns get error"`,
`"unknown feature falls back to raw name"`, or
`"newer timestamps sort before older timestamps"`.
