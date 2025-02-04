class HolidayService 
    
    def get_holidays
        get_url('api/v3/NextPublicHolidays/US')
    end

    def get_url(url)
        response = HTTParty.get("https://date.nager.at/#{url}")
        JSON.parse(response.body, symbolize_names: true)
    end
end