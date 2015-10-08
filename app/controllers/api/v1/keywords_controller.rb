class Api::V1::KeywordsController < ApplicationController
	before_action :doorkeeper_authorize!
	

	include KeywordsConcern
	
end
