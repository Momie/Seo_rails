class GoogleSearch

  @queue = :parser_queue


  def self.perform(keywords)   
    # parse all keywords uploaded by user and find it in google with Mechanize 
    keywords.flatten.each do |key|
      keyword = Word.where({:word=> key}).first || Word.create({:word=> key,:state=>false})
      query = GoogleSearch.worker(key)
      keyword.update_attributes(query) if keyword && query
    end
  end
  ####################################################
  #    funtion to search one word and parsing result #
  #    and return hash with required field           #
  ####################################################
  def self.worker key
    # prepared the required object and form
    agent = Mechanize.new
    # setting mechanize with tor proxy to skip the google limitation
    agent ||= Mechanize.new do |agt|
      agt.set_proxy("localhost", 8888)
    end

    page = agent.get("https://www.google.tn/?gws_rd=cr,ssl&ei=aIwXVvLTJ8T9ywOP45rwCA#")
    search_form = page.form_with(:name => "f")
    search_form.field_with(:name => "q").value = key    
    # start search with keyword
    response = agent.submit(search_form)
    
    return false if response.code != "200" # if no result mabe bad connexion or some problem


    # if seccsuful
    html = Nokogiri::HTML(response.body)
    array_out = {:state=>true}
    array_out[:nb_adwords_top] =  html.xpath("//div[@id='center_col']//ol[1]//li[contains(@class,'ads')]").size
    array_out[:nb_adwords_right] = html.xpath("//td[@id='rhs_block']//ol//li").size
    array_out[:nb_adwords_all] = html.xpath("//li[contains(@class,'ads-ad')]").size
    array_out[:top_adwords_urls] = html.xpath("//div[@id='center_col']//ol[1]//li[contains(@class,'ads')]//cite").map{|e| e.children.first.text()}
    array_out[:right_adwords_urls] = html.xpath("//td[@id='rhs_block']//cite").map{|e| e.children.first.text()}
    array_out[:nb_no_adwords] = html.xpath("//ol//li[@class='g']").size
    array_out[:no_adwords_urls] = html.xpath("//cite").map{|e| e.children.first.text()}
    array_out[:nb_of_links] = html.xpath("//cite").size
    array_out[:all_results_count] = html.xpath("//div[@id='resultStats']").children.text # "21,600,000​  results (0.42 seconds) "  
    array_out[:html_cache] = response.body.force_encoding('iso-8859-1').encode('utf-8')    
    return array_out
  end

end