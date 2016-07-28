defmodule Feeder.Map.Odds.Fixture do
    import SweetXml

    @moduledoc """
    Module that add test map and test url
    """

    @map  matchs: [
     ~x"//Match"l,
     match_id: ~x"./@Id"
  ]

    @doc """
    Returns map from module constant @map"

    ## Example
#        iex> Feeder.Map.Odds.Fixture.map()
         [matchs: [%SweetXpath{cast_to: false, is_keyword: false, is_list: true,
           is_optional: false, is_value: true, path: '//Match'},
          {:match_id,
           %SweetXpath{cast_to: false, is_keyword: false, is_list: false,
            is_optional: false, is_value: true, path: './@Id'}}]]
    """
    def map(), do: @map


    @doc """
    Returns url

    ## Example
        iex> Feeder.Map.Odds.Fixture.url()
        "https://hello_ca_marche"
    """
    def url() do
     "https://hello_ca_marche"
    end
end