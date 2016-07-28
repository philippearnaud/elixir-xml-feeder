defmodule Feeder.Map.Odds.Winamax do
    import SweetXml

    @map  matchs: [
     ~x"//Match"l,
     match_id: ~x"./@Id",
     match_date: ~x"./@Date",
     sport_id: ~x"./Sport/@Id",
     sport_name: ~x"./Sport/@Name",
     category_name: ~x"./Category/@Name",
     category_id: ~x"./Category/@Id",
     tournament_id: ~x"./Tournament/@Id",
     tournament_name: ~x"./Tournament/@Name",
     hometeam: ~x"./HomeTeam/text()",
     awayteam: ~x"./AwayTeam/text()",
     bets: [
         ~x"./Bets"l,
         bet: [
           ~x"./Bet",
           bet_name: ~x"./@BetName",
           bet_code: ~x"./@BetCode",
           outcomes: [
           ~x"./Outcomes"l,
             outcome_text: ~x"./@ResultText",
             outcome_code: ~x"./@ResultCode",
             outcome_odd: ~x"./@Odds",
           ]
         ]
     ]
  ]

    def map(), do: @map

    def url(sport_number) do
     "https://up.winamax.fr/partners/betting/betteur/export.php?sport=#{sport_number}"
    end

end