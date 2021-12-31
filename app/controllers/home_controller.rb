class HomeController < ApplicationController
  API_KEY = "ED7C43E8-4AFE-446D-9CDF-D35C59BB20EA"
  API_DESCRIPTIONS = {
    'good' => 'Good (0-50) - Air quality is satisfactory, and air pollution poses little or no risk.',
    'moderate' => 'Moderate (51-100) - Air quality is acceptable. However, there may be a risk for some people, particularly those who are unusually sensitive to air pollution.',
    'sensitive' => 'Sensitive Groups (101-150) - Members of sensitive groups may experience health effects. The general public is less likely to be affected.',
    'unhealthy' => 'Unhealthy (151-200) - Some members of the general public may experience health effects; members of sensitive groups may experience more serious health effects.',
    'very_unhealthy' => 'Very Unhealthy (201-300) - Health alert: The risk of health effects is increased for everyone.',
    'hazardous' => 'Good (301-500) - Health warning of emergency conditions: everyone is more likely to be affected.',
    'error' => 'No results found',
  }

  def index
    require 'net/http'
    require 'json'

    zip = '84047'
    # zip = '89129'
    distance = 25
    @url = "https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=#{zip}&distance=#{distance}&API_KEY=#{API_KEY}"
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    if !@output or @output.empty?
      @final_output = 'Error'
    else
      @final_output = @output[0]['AQI']
    end

    case @final_output
      when 0...50 
        @api_color = 'green'
        @api_description = API_DESCRIPTIONS['good']
      when 51...100 
        @api_color = 'yellow'
        @api_description = API_DESCRIPTIONS['moderate']
      when 101...150 
        @api_color = 'orange'
        @api_description = API_DESCRIPTIONS['sensitive']
      when 151...200 
        @api_color = 'red'
        @api_description = API_DESCRIPTIONS['unhealthy']
      when 201...300 
        @api_color = 'purple'
        @api_description = API_DESCRIPTIONS['very_unhealthy']
      when 301...500 
        @api_color = 'maroon'
        @api_description = API_DESCRIPTIONS['hazardous']
      else
        @api_color = 'secondary' 
        @api_description = API_DESCRIPTIONS['error']
    end
  end
end
