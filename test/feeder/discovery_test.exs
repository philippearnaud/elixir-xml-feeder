defmodule Feeder.DiscoveryTest do
  use ExUnit.Case
  alias Feeder.Discovery

  doctest Feeder.Discovery

  test "WINAMAX Check if discoveries url are working" do
      sport_numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9 , 10, 11, 12, 13, 14, 15]
      Enum.each(sport_numbers,
      fn(sport_number) ->
       assert Discovery.url({"winamax", "odds"}, %{sport_number: sport_number}) == "https://up.winamax.fr/partners/betting/betteur/export.php?sport=#{sport_number}"
      end)
  end

  test "WINAMAX - Check if discoveries Map is working" do
    assert Discovery.map({"winamax", "odds"}) == Feeder.Map.Odds.Winamax.map()
  end
end
