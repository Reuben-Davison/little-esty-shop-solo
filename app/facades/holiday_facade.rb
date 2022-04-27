class HolidayFacade 

    def holidays 
        holiday_data.map do |data|
            Holiday.new(data)
        end        
    end

    def holiday_data 
        @_holiday_data ||= service.get_holidays[0..2]
    end

    def service 
        @_service ||= HolidayService.new
    end
end