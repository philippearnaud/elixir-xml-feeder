defmodule Feeder.Mixfile do
  use Mix.Project

  def project do
    [app: :feeder,
     version: "0.0.1",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :quantum, :tzdata],
     mod: {Feeder, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # To depend on another app inside the umbrella:
  #
  #   {:myapp, in_umbrella: true}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:quantum, ">= 1.7.1"},
    {:sweet_xml, "~> 0.5.0"},
    {:ex_doc, "~> 0.11", only: :dev},
    {:earmark, "~> 0.1", only: :dev},
    {:timex, "~> 2.1.1"}
    ]
  end
end
