class Word < ActiveRecord::Base
	serialize :top_adwords_urls,Array
	serialize :right_adwords_urls,Array
	serialize :no_adwords_urls,Array

end
