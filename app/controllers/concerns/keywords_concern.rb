
require 'csv'

module KeywordsConcern
    extend ActiveSupport::Concern

    def upload
      # check if valid data
      if ["text/csv","application/vnd.ms-excel"].include? params[:keys].content_type
        keys = CSV.parse(params[:keys].read,{:col_sep => ";", :headers => false,  :skip_blanks => true}).map
        if keys.size.between?(1, 1000)  
          render :text => keys.to_json
        else
          render :text => "Number of keywords Out of range max 1000"
        end
      
      else
       render text: "Failed to upload"
      end
    end

end