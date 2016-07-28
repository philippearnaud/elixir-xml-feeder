defmodule Feeder.Map.Test.Fixture do
    import SweetXml

    @moduledoc """
    Module that add test map and test url
    """

    @xml """
    <xml>
           <Weather date='25-07-2016 ' location='Paris'>
               <cloudy>true</cloudy>
               <cloudy_hours hour='19' sky_cloud_coverage='100'/>
               <cloudy_hours hour='20' sky_cloud_coverage='100'/>
               <cloudy_hours hour='21' sky_cloud_coverage='100'/>
           </Weather>
           <Weather date='25-07-2016' location='San Francisco'>
                <cloudy>true</cloudy>
               <cloudy_hours hour='19' sky_cloud_coverage='100'/>
               <cloudy_hours hour='20' sky_cloud_coverage='100'/>
               <cloudy_hours hour='21' sky_cloud_coverage='100'/>
           </Weather>
           <Weather date='25-07-2016' location='London'>
               <cloudy>true</cloudy>
               <cloudy_hours hour='19' sky_cloud_coverage='100'/>
               <cloudy_hours hour='20' sky_cloud_coverage='100'/>
               <cloudy_hours hour='21' sky_cloud_coverage='100'/>
           </Weather>
     </xml>
    """

    @map matchs: [
       ~x"//Weather"l,
       date: ~x"./@date",
       location: ~x"./@location",
       cloudy: ~x"./cloudy/text()",
       cloudy_hours: [
         ~x"./cloudy_hours"l,
         hour: ~x"./@hour",
         sky_cloud_coverage: ~x"./@sky_cloud_coverage"
       ]
     ]

    @doc """
    Returns map from module constant @map"

    ## Example
        iex> Feeder.Map.Test.Fixture.map()
        [matchs: [%SweetXpath{cast_to: false, is_keyword: false, is_list: true, is_optional: false, is_value: true, path: '//Weather'},
                     {:date, %SweetXpath{cast_to: false, is_keyword: false, is_list: false, is_optional: false, is_value: true, path: './@date'}},
                     {:location, %SweetXpath{cast_to: false, is_keyword: false, is_list: false, is_optional: false, is_value: true, path: './@location'}},
                     {:cloudy, %SweetXpath{cast_to: false, is_keyword: false, is_list: false, is_optional: false, is_value: true, path: './cloudy/text()'}},
                     {:cloudy_hours,
                      [%SweetXpath{cast_to: false, is_keyword: false, is_list: true, is_optional: false, is_value: true, path: './cloudy_hours'},
                       {:hour, %SweetXpath{cast_to: false, is_keyword: false, is_list: false, is_optional: false, is_value: true, path: './@hour'}},
                       {:sky_cloud_coverage, %SweetXpath{cast_to: false, is_keyword: false, is_list: false, is_optional: false, is_value: true, path: './@sky_cloud_coverage'}}]}]]

    """
    def map(), do: @map


    @doc """
    Returns url

    ## Example
        iex> Feeder.Map.Test.Fixture.url("paris-london-sf")
        "https://weatherilike.com/api/weather/today.xml?cities='paris-london-sf'"
    """
    def url(cities) do
     "https://weatherilike.com/api/weather/today.xml?cities='#{cities}'"
    end


    @doc """
     Returns fixture xml
    """
    def xml() do
        @xml
    end
end