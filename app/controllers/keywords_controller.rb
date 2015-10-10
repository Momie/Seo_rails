class KeywordsController < ApplicationController
	   
	before_action :authenticate_user!

	autocomplete :word, :word

	include KeywordsConcern

    def index
      unless params[:key].blank?
      	case params[:type]
      	  when '1' then
      	  	Word.where('word LIKE ?', "%#{params[:key]}%").all
      	  when '2' then
      	  	Word.where('top_adwords_urls LIKE ? or right_adwords_urls  LIKE ? ', "%#{params[:key]}%","%#{params[:key]}%").all
      	end		
      else	
    	@result = []
      end
    end

    def upload_file
    end

end
