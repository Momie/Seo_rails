class Report < ActiveRecord::Base
	
	belongs_to :user #report created by this user

	serialize :report, JSON

	# generate report_field automatically before save report
	
	before_save :fill_report

	def fill_report
	  self.report = Word.order(word: :asc).as_json
	end 
end
