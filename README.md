# About

A CLI tool to generate activity for detection by endpoint agents

## Usage

Get started with a sample script by running:

    ruby generate.rb config.example.yml

The operation order and parameters are controlled by the first and only parameter.
It should be a YAML syntax file listing the operations, the example file includes samples
of all operations and parameters.

The output is JSON format, and debug logs are printed to STDERR.  To get the events in a
shippable format try:

    ruby generate.rb config.example.yml > events.json

## Developing

The project has been developed as a functional Proof of Concept on OS X.  It is not a gem although
the major file structure could easily be ported into a gem.

Each operation type is defined under `lib/operations`, additional operations should be defined
there.  Any OS Specific operation should be defined in a subfolder and conditionally loaded in
`edr_activity_generator.rb`

Every operation should return a singular event.  The event object is responsible for holding
information about the operation and formatting it.

Operations are run by the `EdrActivityGenerator`

### Testing

Tests are currently basic but functional.  Run `rake` to exercise the tests.

### Linux Testing

Run `docker build -t edr_generator .` to build a linux image.  Exercise tests with
`docker run --rm edr_generator rake` and run the example with
`docker run --rm edr_generator generate.rb config.example.yml`

### Improvement ideas

* Expanded tests
* Convert to a gem
* Separate `edr_activity_generator.rb` into a library loader and runner class definition
* Improve CLI invocation in `generate.rb` to specify log level, output format, output location, or operations
* Subclass or smart-ify `Event` so that only fields relevant to the operation type are included
* Add additional output formats beyond JSON
