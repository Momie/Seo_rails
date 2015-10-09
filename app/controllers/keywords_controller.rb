class KeywordsController < ApplicationController
	   
	before_action :authenticate_user!

	include KeywordsConcern

    def index
    	   	 
    end

    def upload_file

    end

end
