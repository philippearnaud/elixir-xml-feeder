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

  == Example

      iex> Feeder.Parser.fetch({"test", "odds"})
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

      iex> Feeder.Parser.parse_xml({:ok, "<xml><Match Id='21312'></Match></xml>"}, {"test", "odds"})
      {:ok, %{matchs: [%{match_id: '21312'}]}}

      iex> Feeder.Parser.parse_xml({:error, "fail"}, {"test", "odds"})
      {:error, "fail"}
  """
  def parse_xml({:ok, body}, service, options \\ nil) do
    collection = body |> xmap(Discovery.map(service, options))
    {:ok, collection}
  end
  def parse_xml({:error, body}, _, _) do
    {:error, body}
  end
end
