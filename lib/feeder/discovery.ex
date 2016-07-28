defmodule Feeder.Discovery do
  alias Feeder.Map.Test.Fixture, as: Test_fixture

  @moduledoc """
  Feeder.Discovery xml parser library aims to find
  proper url for API and also proper mapping in case of multiple
  call to external API
  """

  @doc """
    Associate a xml mapping with the service asked

    returns a map

    ## Example

        iex> Feeder.Discovery.map({"unknown", "unknown"})
        nil

  """
  def map(service, options \\ :empty) do
    { tiers, service_type }  =  service
    case { tiers, service_type} do
     {"weather", "today"} -> Test_fixture.map()
      _ -> nil
    end
  end

  @doc """
    Associate a url with the service asked

    return a binary

    ## Example

        iex> Feeder.Discovery.url({"weather", "today"}, %{cities: "paris-london-sf"})
        "https://weatherilike.com/api/weather/today.xml?cities='paris-london-sf'"
  """
  def url(service, options \\ nil) do
    { tiers, service_type } =  service
    case { tiers, service_type} do
     {"weather", "today"} -> Test_fixture.url(options[:cities])
      _ -> nil
    end
  end
end
