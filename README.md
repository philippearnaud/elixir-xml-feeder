# elixir-xml-feeder
Tool that allow elixir developers to work with third party xml external API with almost no pain. Just describe the xml mapping and a the resource url and you are all set to retrieve a elixir formatted output. You can register as much API you want.

You can help me improve the module to make it really better.
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

## How to use it

  1. First, you import or alias the module in the part of your code when you want to call the API and have the
  result.
  2. Secondly, you call Feeder.Parser.fetch with the appropriate arguments (defined in 4).
  3. Thirdly, you have to create a map module which would have a map constant containing the sweetXml mapping and
  the url of the external api.
  4. Second, you have to reference this map module in the Feeder.discovery module both in url and in map.

## One example

I want to retrieve information from a (fictional for the example) XML API called "Weather" and i want one specific resource
called "today", the url is "https://weatherilike.com/api/weather/today.xml?cities="paris-london-sf"

The XML retrieve from the url  could be like this

    <xml>
       <Weather date="25-07-2016 " location="Paris">
           <cloudy>true</cloudy>
           <cloudy_hours hour="19" sky_cloud_coverage="100">
           <cloudy_hours hour="20" sky_cloud_coverage="100">
           <cloudy_hours hour="21" sky_cloud_coverage="100">
       </Weather>
       <Weather date="25-07-2016" location="San Francisco">
            <cloudy>true</cloudy>
           <cloudy_hours hour="19" sky_cloud_coverage="100">
           <cloudy_hours hour="20" sky_cloud_coverage="100">
           <cloudy_hours hour="21" sky_cloud_coverage="100">
       </Weather>
       <Weather date="25-07-2016" location="London">
           <cloudy>true</cloudy>
           <cloudy_hours hour="19" sky_cloud_coverage="100">
           <cloudy_hours hour="20" sky_cloud_coverage="100">
           <cloudy_hours hour="21" sky_cloud_coverage="100">
       </Weather>
    </xml>


We are going to trigger the Feeder.Parser module

     defmodule TriggeringModule do
        alias Feeder.Parser
        def do
         Parser.fetch({"weather", "today"}, %{cities: "paris-london-sf"})
       end
     end

We need to create a module with the SweetXml mapping and the url

     defmodule YourModule do
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

        def map() do
          @map
        end




        # In our case we want the url to be dynamically defined so we passed into arguments
        a variable we are going to defined in the Feeder.Discovery module
        def url(cities) do
           "https://weatherilike.com/api/weather/today.xml?cities=#{cities}"
        end
     end
Then we will add a new entry in Feeder.Parser.Discovery.map() and a new one in Feeder.Parser.Discovery.url()

    defmodule Feeder.Parser.Discovery do

         def map(service, options \\ :empty) do
           { tiers, service_type }  =  service
           case { tiers, service_type} do
             { "weather", "today" } -> Mymodule.map()
             _ -> nil
           end
        end

         def url(service, options \\ nil) do
            { tiers, service_type } =  service
            case { tiers, service_type} do
              { "weather", "today" } -> Mymodyle.url(options[:cities])
              _ -> nil
            end
         end
     end


Then all it will works fine.



