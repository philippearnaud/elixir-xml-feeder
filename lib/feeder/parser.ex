require IEx
defmodule Feeder.Parser do
  import SweetXml
  alias Feeder.Discovery

  @user_agent [{"User-agent", "Yourself"}]

  @moduledoc """
    This module aims to fetch, parse and returns a elixir formatted map
    from any xml third party API
  """

  @doc """
  In charge of making the RPC to third party API
  then passing the response to our handler and to our
  xml Parser

  ## Example

      iex> Feeder.Parser.fetch({"unknown", "unknow"})
      {:error, "nil"}
  """
  def fetch(services, options \\ nil) do
      HTTPoison.start
      Discovery.url(services, options)
      |> HTTPoison.get(@user_agent,[connect_timeout: 1000000, recv_timeout: 1000000, timeout: 1000000])
      |> handle_response
      |> parse_xml(services, options)
   end

   @doc """
   Handle the response from HTTPoison call to remote resource.

    ## Example

        iex> Feeder.Parser.handle_response({:ok, %{status_code: 200, body: "<xml></xml>"}})
        {:ok, "<xml></xml>"}

        iex> Feeder.Parser.handle_response({:error, %{status_code: 500, body: "<xml></xml>"}})
        {:error, "<xml></xml>"}

        iex> Feeder.Parser.handle_response({:error, %HTTPoison.Error{id: 30, reason: "not nice"}})
        {:error, "nil"}

   """
  def handle_response({:ok, %{status_code: 200, body: body}}) do
     {:ok, body}
  end
  def handle_response({_, %{status_code: _, body: body}}) do
    {:error, body}
  end
  def handle_response({:error, %HTTPoison.Error{id: _, reason: _}}) do
    {:error, "nil"}
  end

  @doc """
  Parse Xml given a certain body, services and options.

  ## Example

      iex> Feeder.Parser.parse_xml({:error, "fail"}, {"weather", "today"})
      {:error, "fail"}

      #Discovery.xml() is just used for testing purpose
      iex> Feeder.Parser.parse_xml({:ok, Feeder.Map.Test.Fixture.xml()}, {"weather", "today"}, %{cities: "paris-london-sf"})
      {:ok,
                  %{matchs: [%{cloudy: 'true',
                       cloudy_hours: [%{hour: '19', sky_cloud_coverage: '100'}, %{hour: '20', sky_cloud_coverage: '100'}, %{hour: '21', sky_cloud_coverage: '100'}],
                       date: '25-07-2016 ', location: 'Paris'},
                     %{cloudy: 'true', cloudy_hours: [%{hour: '19', sky_cloud_coverage: '100'}, %{hour: '20', sky_cloud_coverage: '100'}, %{hour: '21', sky_cloud_coverage: '100'}],
                       date: '25-07-2016', location: 'San Francisco'},
                     %{cloudy: 'true', cloudy_hours: [%{hour: '19', sky_cloud_coverage: '100'}, %{hour: '20', sky_cloud_coverage: '100'}, %{hour: '21', sky_cloud_coverage: '100'}],
                       date: '25-07-2016', location: 'London'}]}}


  """
  def parse_xml({:ok, body}, service, options \\ nil) do
    collection = body |> xmap(Discovery.map(service, options))
    {:ok, collection}
  end
  def parse_xml({:error, body}, _, _) do
    {:error, body}
  end
end
