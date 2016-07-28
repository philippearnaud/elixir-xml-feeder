# elixir-xml-feeder
Tool that allow elixir developers to work with third party xml external API with almost no pain. Just describe the xml mapping and a the resource url and you are all set to retrieve a elixir formatted output. You can register as much API you want.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add feeder to your list of dependencies in `mix.exs`:

        def deps do
          [{:feeder, "~> 0.0.1"}]
        end

  2. Ensure feeder is started before your application:

        def application do
          [applications: [:feeder]]
        end

