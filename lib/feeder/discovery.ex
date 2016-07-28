defmodule Feeder.Discovery do
  alias Feeder.Map.Odds.Winamax, as: Odds_Winamax
  alias Feeder.Map.Odds.Fixture, as: Odds_Fixture

  @moduledoc """
  Feeder.Discovery aims xml parser library to find
  proper url for API and also proper mapping to
  match our db model.
  """

  @doc """
    Associate a xml mapping with the service asked

    returns a map

    ## Example

        iex> Feeder.Discovery.map({"test", "odds"})
        [matchs: [%SweetXpath{cast_to: false, is_keyword: false, is_list: true,
           is_optional: false, is_value: true, path: '//Match'},
          {:match_id,
           %SweetXpath{cast_to: false, is_keyword: false, is_list: false,
            is_optional: false, is_value: true, path: './@Id'}}]]

  """
  def map(service, options \\ :empty) do
    { tiers, service_type }  =  service
    case { tiers, service_type} do
      { "winamax", "odds" } -> Odds_Winamax.map()
      { "test", "odds" } -> Odds_Fixture.map()
      _ ->
    end
  end

  @doc """
    Associate a url with the service asked

    return a binary

    ## Example

        iex> Feeder.Discovery.url({"test", "odds"})
        "https://hello_ca_marche"

        iex> Feeder.Discovery.url({"winamax", "odds"}, %{sport_number: 1})
        "https://up.winamax.fr/partners/betting/betteur/export.php?sport=1"
  """
  def url(service, options \\ nil) do
    { tiers, service_type } =  service
    case { tiers, service_type} do
      { "winamax", "odds" } -> Odds_Winamax.url(options[:sport_number])
      { "test", "odds" } -> Odds_Fixture.url()
      _ ->
    end
  end
end
