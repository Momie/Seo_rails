class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
        t.string            :word, null: false
        t.boolean			:state, null: false
        t.integer           :nb_adwords_top 
        t.integer           :nb_adwords_right 
        t.integer           :nb_adwords_all 
        t.text              :top_adwords_urls
        t.text              :right_adwords_urls
        t.integer           :nb_no_adwords
        t.text              :no_adwords_urls
        t.integer           :nb_of_links
        t.string            :all_results_count
        t.text              :html_cache
        t.timestamps null: false
    end
    add_index :words, :word, unique: true
    add_index :words, :state
 	add_index :words, [:state,:nb_adwords_all]
 	add_index :words, [:state,:nb_no_adwords]
 	add_index :words, [:state,:all_results_count]

  end
end
